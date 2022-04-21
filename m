Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C928A50AA38
	for <lists+linux-api@lfdr.de>; Thu, 21 Apr 2022 22:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357031AbiDUUox (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Apr 2022 16:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245040AbiDUUow (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Apr 2022 16:44:52 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C49D4D269;
        Thu, 21 Apr 2022 13:42:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2edbd522c21so64782267b3.13;
        Thu, 21 Apr 2022 13:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYKJhmRFx1F8adLuAIcMpQnLKlvX9Z1XUl3E7aLlV8E=;
        b=YvQuJrE/4vqkSe9O2kKAiCMaNp9m5twmUooW4PqgiKdFsIpGTgVukIBgAB5FFLE96q
         7JE2dAtETwyMCu6F65v4G1Ne6yz64d7o32174mr1EPoi6s8w16WWa4Lwsyf32Wuhpx1F
         U4Y+kGkQ2C98EbvdUcAtYdP8ND5tUwT/6o597nJttWkQnr6JGTVX6EWdilbbpdcwAhA3
         51eycRzhyjcv3F8TpDB+xkL1dRPnwDSYcJjiXepAbM7gAx8cEou71E7n/ZPnyhItIepo
         ZZ0Txw8CUdWN0x3v03IP16owr2txUq0r1Yk+qYiYYnnodsiIaW5GqWGMCPxfZUZPUmds
         WEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYKJhmRFx1F8adLuAIcMpQnLKlvX9Z1XUl3E7aLlV8E=;
        b=okm6d9+WQ2Gl/Drukwcq76UDfpY6ex++68u/9PPI4ad3wasT3DGAqd9hAoHJJc50pO
         pm/PqUtLOQ3Tkv1b+4ZfMybtVB//yMihkxek7oA9z0fh77PhPtJSLnKE1VJWD6e62joP
         uApz7FFM+VLUwKk2RFU6Cn7dKUmUR6yBAe+zd4zHPQWIqYoWBck1NezteMS2JNllHAG8
         UXTFo0+t88ZR0EvdB8sY5ot2wpnQPnL/yDNv66JSdHyQ7kLQmhAY/guP94NRYAGR14Y7
         MG06iHR56tNFOGAAcXLcHhioFspDkWX3RnrTMguNXVnX0h/5xZ7p1XZs2XCdy5YzXqYW
         /MQA==
X-Gm-Message-State: AOAM530raNy1EIuo8rnE8bd2ahVk8A1wU6q3qoUjXmUVOI5ypTg0gtDx
        8KPuIi0DFhU1valOnp9OcvWKCK4b+cas5FJjTHA=
X-Google-Smtp-Source: ABdhPJzyzFCsO/dqhqRgWPbjXueuWNVd9afSrie9vi9NYSiBgbJNQgOJCWJXSk55V74rC+c7ZK6UiKVMEpzxSxlFGqU=
X-Received: by 2002:a81:fcf:0:b0:2f4:d321:2dbf with SMTP id
 198-20020a810fcf000000b002f4d3212dbfmr1701415ywp.116.1650573720633; Thu, 21
 Apr 2022 13:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220421153626.120494-1-vicencb@gmail.com> <20220421193851.GA12186@wunner.de>
In-Reply-To: <20220421193851.GA12186@wunner.de>
From:   Vicente Bergas <vicencb@gmail.com>
Date:   Thu, 21 Apr 2022 22:41:49 +0200
Message-ID: <CAAMcf8AQLmtHTEevY3i3fo7uWOmVo5PLoq1oScjt0rXdk4yX6Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
To:     Lukas Wunner <lukas@wunner.de>
Cc:     ilpo.jarvinen@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        giulio.benetti@micronovasrl.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        heikki.krogerus@linux.intel.com,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        jirislaby@kernel.org, johan@kernel.org, linux-api@vger.kernel.org,
        linux-serial@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Lukas,

On Thu, Apr 21, 2022 at 9:38 PM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Thu, Apr 21, 2022 at 05:36:26PM +0200, Vicente Bergas wrote:
> > 2.- Although "linux,rs485-enabled-at-boot-time" is set in the DTS,
> > the RTS/DriverEnable line is asserted all the time the /dev/ttyS1
> > device file is closed.
> > As soon as the device file is openned, the RTS line is deasserted.
> > Then it works as expected: it is asserted only during transmissions.
> > When the device file is closed again, the RTS line goes back to the
> > asserted level and stays there.
> > When the rs485 mode is enabled, it is expected that the RTS line be
> > deasserted by default.
>
> That's probably the same issue as reported here:
>
> https://lore.kernel.org/linux-serial/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/
>
> Basically, some drivers have historically used inverse RTS polarity
> and others haven't.  I'm still busy sorting out which drivers use
> which.  Sorry, this is quite complex and takes some time.
>
> Have you configured "rs485-rts-active-low" in the device tree?

The UART configuration is the default from rk3328.dtsi plus:
&uart1 {
  linux,rs485-enabled-at-boot-time;
  pinctrl-0 = <&uart1_xfer &uart1_cts &uart1_rts_pin>;
  rs485-rts-delay = <0 52>;
  rs485-rx-during-tx;
  rts-gpios = <&gpio3 RK_PA5 GPIO_ACTIVE_HIGH>;
  status = "okay";
};

So, it is asserted high and deasserted low.

> Which kernel version are you using exactly?

5.17.3 and 5.17.4
Also, i am about to test 5.18-rc3

> Thanks,
>
> Lukas

Regards,
  Vicente.
