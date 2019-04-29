Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4265CDCE9
	for <lists+linux-api@lfdr.de>; Mon, 29 Apr 2019 09:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfD2HeG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Apr 2019 03:34:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:40728 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2HeG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Apr 2019 03:34:06 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hL0nY-00059b-7m; Mon, 29 Apr 2019 09:34:00 +0200
Date:   Mon, 29 Apr 2019 09:33:59 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Joseph Myers <joseph@codesourcery.com>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Lukasz Majewski <lukma@denx.de>,
        Stepan Golosunov <stepan@golosunov.pp.ru>
Subject: Re: [PATCH 1/2] y2038: make CONFIG_64BIT_TIME unconditional
In-Reply-To: <20190426142531.1378357-1-arnd@arndb.de>
Message-ID: <alpine.DEB.2.21.1904290933130.1626@nanos.tec.linutronix.de>
References: <20190426142531.1378357-1-arnd@arndb.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 26 Apr 2019, Arnd Bergmann wrote:

> As Stepan Golosunov points out, we made a small mistake in the
> get_timespec64() function in the kernel. It was originally added under
> the assumption that CONFIG_64BIT_TIME would get enabled on all 32-bit
> and 64-bit architectures, but when I did the conversion, I only turned
> it on for 32-bit ones.
> 
> The effect is that the get_timespec64() function never clears the upper
> half of the tv_nsec field for 32-bit tasks in compat mode. Clearing this
> is required for POSIX compliant behavior of functions that pass a
> 'timespec' structure with a 64-bit tv_sec and a 32-bit tv_nsec, plus
> uninitialized padding.
> 
> The easiest fix for linux-5.1 is to just make the Kconfig symbol
> unconditional, as it was originally intended. As a follow-up,
> we should remove any #ifdef CONFIG_64BIT_TIME completely.
> 
> Link: https://lore.kernel.org/lkml/20190422090710.bmxdhhankurhafxq@sghpc.golosunov.pp.ru/
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Stepan Golosunov <stepan@golosunov.pp.ru>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Please apply this one as a bugfix for 5.1

Can you provide a 'Fixes: ....' tag please?

Thanks,

	tglx
