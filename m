Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AD850A95C
	for <lists+linux-api@lfdr.de>; Thu, 21 Apr 2022 21:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392069AbiDUTlw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 21 Apr 2022 15:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392036AbiDUTlr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 21 Apr 2022 15:41:47 -0400
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12A54D621;
        Thu, 21 Apr 2022 12:38:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0F83030004812;
        Thu, 21 Apr 2022 21:38:52 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id EE33AA6007; Thu, 21 Apr 2022 21:38:51 +0200 (CEST)
Date:   Thu, 21 Apr 2022 21:38:51 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     ilpo.jarvinen@linux.intel.com, andriy.shevchenko@linux.intel.com,
        giulio.benetti@micronovasrl.com, gregkh@linuxfoundation.org,
        heikki.krogerus@linux.intel.com, heiko@sntech.de,
        jirislaby@kernel.org, johan@kernel.org, linux-api@vger.kernel.org,
        linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v3 00/12] Add RS485 support to DW UART
Message-ID: <20220421193851.GA12186@wunner.de>
References: <20220411083321.9131-1-ilpo.jarvinen@linux.intel.com>
 <20220421153626.120494-1-vicencb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421153626.120494-1-vicencb@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 21, 2022 at 05:36:26PM +0200, Vicente Bergas wrote:
> 2.- Although "linux,rs485-enabled-at-boot-time" is set in the DTS,
> the RTS/DriverEnable line is asserted all the time the /dev/ttyS1
> device file is closed.
> As soon as the device file is openned, the RTS line is deasserted.
> Then it works as expected: it is asserted only during transmissions.
> When the device file is closed again, the RTS line goes back to the
> asserted level and stays there.
> When the rs485 mode is enabled, it is expected that the RTS line be
> deasserted by default.

That's probably the same issue as reported here:

https://lore.kernel.org/linux-serial/20220329085050.311408-1-matthias.schiffer@ew.tq-group.com/

Basically, some drivers have historically used inverse RTS polarity
and others haven't.  I'm still busy sorting out which drivers use
which.  Sorry, this is quite complex and takes some time.

Have you configured "rs485-rts-active-low" in the device tree?
Which kernel version are you using exactly?

Thanks,

Lukas
