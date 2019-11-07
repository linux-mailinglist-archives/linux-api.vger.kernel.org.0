Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74AF2DD4
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 13:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKGMAX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 07:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727178AbfKGMAX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 7 Nov 2019 07:00:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A121218AE;
        Thu,  7 Nov 2019 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573128022;
        bh=84KySv+2LP+J3/Kji0hGhsfyASa0j9F2JC0pXb5m0Oc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vu14avBGrPpLeKGggxJ05vEyV9t8Csv2oqXVcJp/HSduX1wzpTtIgdW8tYLo5u5tO
         MQ0OfMQyy10qvw6Dh4kUkmHuvBKagk3APgw1jXSNcQ4b97yKsOhe6Od7/GV+PKSo8V
         hc6D3PJFW/KHtXhfOedFqCPzTCCZoobuTUshRKf4=
Date:   Thu, 7 Nov 2019 13:00:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elichai Turkel <elichai.turkel@gmail.com>
Cc:     linux-api@vger.kernel.org
Subject: Re: Continuing the UAPI split
Message-ID: <20191107120019.GK102492@kroah.com>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 07, 2019 at 01:17:50PM +0200, Elichai Turkel wrote:
> Hi,
> I'm working on a library that calls syscalls directly to the kernel.
> `make hedears_install` is a great command to auto generate the UAPI
> headers that are needed to call the kernel.
> 
> But the headers are still missing a bunch of defines for flags and structs.
> 
> I wanted to know if patches to move more things from `./include/linux`
> to `./include/uapi/linux` are welcome (obviously only
> typedefs/defines/structs that are required for the syscalls)

Yes, fixing this up to make the in-kernel headers clean enough for libc
projects to consume them directly is a very good idea and are welcome.

Note we have a bunch of ioctl structures that seem to be buried in
driver header files, those also need to get exported properly as well.

thanks,

greg k-h
