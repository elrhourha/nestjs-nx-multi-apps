import { Controller, Get } from '@nestjs/common';

import { AppService } from './app.service';
import {commonsEntities} from "commons-entities";

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getData() {
    return commonsEntities()
  }
}
