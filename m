Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7CCF11CB93
	for <lists+linux-api@lfdr.de>; Thu, 12 Dec 2019 11:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728920AbfLLK55 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Dec 2019 05:57:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:49512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728784AbfLLK54 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 12 Dec 2019 05:57:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7ED9214D8;
        Thu, 12 Dec 2019 10:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576148276;
        bh=efVjjQG6UNoj6c0lJ3KZywfrNSIcf/ci6H+eEgtsTEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIZUGbB5HlPD3M7fra6t0v3E4z6A2gSNs+Dumsk/xrse3/DeZY82vaPqiZhADE+dH
         WC1Z5XodnJcXvvoBUdYmPO2tlMtHQKnw6ENXgegzU7YTy7Fm1bCxt4w1h++/yiz6VG
         2MwBCnXujAaYG6EHQ8hxaIJ+LVuQ7fskCptM8H9Q=
Date:   Thu, 12 Dec 2019 11:57:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+92f32d4e21fb246d31a2@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, asierra@xes-inc.com,
        corbet@lwn.net, ext-kimmo.rautkoski@vaisala.com, jslaby@suse.com,
        kai.heng.feng@canonical.com, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, mika.westerberg@linux.intel.com,
        paulburton@kernel.org, peter@hurleysoftware.com, sr@denx.de,
        syzkaller-bugs@googlegroups.com, yamada.masahiro@socionext.com,
        yegorslists@googlemail.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 mem16_serial_out
Message-ID: <20191212105754.GC1476206@kroah.com>
References: <00000000000044a65205994a7e13@google.com>
 <00000000000003cc8505994f9036@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000003cc8505994f9036@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Dec 09, 2019 at 05:38:01PM -0800, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit bd94c4077a0b2ecc35562c294f80f3659ecd8499
> Author: Masahiro Yamada <yamada.masahiro@socionext.com>
> Date:   Wed Oct 28 03:46:05 2015 +0000
> 
>     serial: support 16-bit register interface for console

That would be because that is when this function was added to the kernel
:)

Again, you are asking the kernel to write to a bad place in memory, and
then crash when that happens.  That sounds like the correct
functionality to me...

thanks,

greg k-h
