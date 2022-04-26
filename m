Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2E50FD8F
	for <lists+linux-api@lfdr.de>; Tue, 26 Apr 2022 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245622AbiDZMwM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Apr 2022 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiDZMwL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 26 Apr 2022 08:52:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9B4179EAB;
        Tue, 26 Apr 2022 05:49:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A8C561964;
        Tue, 26 Apr 2022 12:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED103C385AC;
        Tue, 26 Apr 2022 12:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650977343;
        bh=qr+3xq+EUXxwa36H98K/79oVfhas8KZ1uED5UHmjuJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RJzBIYsNnPOzkTDnhHXOw/fe1AGr09YBjboHMLLndrtnNK2u6P0Cpj5nEK9gw232a
         MSlNY+bIbkE24bMDNd9Jpnb67wnTq1RMpKO2snF0SkIChRKxVQ0U+XvHmInFth6/Ee
         ZUGngXXBdBryic5UDin/p28LSn0YoBO3U02zRZwE=
Date:   Tue, 26 Apr 2022 14:49:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Vicente Bergas <vicencb@gmail.com>,
        Johan Hovold <johan@kernel.org>, heiko@sntech.de,
        giulio.benetti@micronovasrl.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v5 00/10] Add RS485 support to DW UART
Message-ID: <YmfqPMyYLAXw1BNo@kroah.com>
References: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220426122448.38997-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 26, 2022 at 03:24:38PM +0300, Ilpo Järvinen wrote:
> This patchset adds RS-485 support to the DW UART driver. The patchset
> has two main parts. The first part adds HW support for RS-485 itself
> in various modes of operation and the second part focuses on enabling
> 9th bit addressing mode that can be used on a multipoint RS-485
> communications line.
> 
> To configure multipoint addressing, ADDRB flag is added to termios
> and two new IOCTLs are added into serial core. Lukas Wunner brought up
> during v1 review that if this addressing is only going to be used with
> RS-485, doing it within rs485_config would avoid having to add those
> IOCTLs. There was some counterexample w/o further details mentioned for
> RS-232 usage by Andy Shevchenko. I left the IOCTL approach there but if
> somebody has further input on this, please voice it as it is user-space
> facing API.
> 
> I decided to rewrite the UART_CAP_NOTEMT patch from scratch myself
> based on Uwe Kleine-König's earlier suggestion and include it to this
> series. To make waiting for a single character easy and to avoid
> storing it per purpose in the uart drivers, I decided to add
> frame_time into uart_port. It turned out to beneficial also for serial
> core which had to reverse calculate it from uart_port->timeout). I was
> thinking of removing uart_port->timeout entirely and derive the value
> timeout from frame_time and fifosize where needed but I was not sure
> if that's ok to do lockingwise (not that fifosize is a variable that
> is expected to change so maybe I'm just being too cautious).

I've applied the first 4 now, thanks.

greg k-h
