import { Controller, Get } from '@nestjs/common';

import { AppService } from './app.service';
import axios from "axios";
import * as process from "process";

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  async getData() {
    const response = await axios.get(process.env.MICRO_SERVICE2);
    console.log(`Response from MS2:`, response.data)
    return this.appService.getData();
  }
}
