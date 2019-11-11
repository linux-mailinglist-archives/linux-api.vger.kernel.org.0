Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 012E9F73E6
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2019 13:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKKMbV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 07:31:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfKKMbV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 07:31:21 -0500
Received: from p54ac5540.dip0.t-ipconnect.de ([84.172.85.64] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iU8qk-0000Ls-Tz; Mon, 11 Nov 2019 12:31:18 +0000
Date:   Mon, 11 Nov 2019 13:31:18 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian@brauner.io>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 23/23] y2038: allow disabling time32 system calls
Message-ID: <20191111123116.upuqpdetbxdmfp3i@wittgenstein>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-14-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-14-arnd@arndb.de>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Nov 08, 2019 at 10:12:22PM +0100, Arnd Bergmann wrote:
> At the moment, the compilation of the old time32 system calls depends
> purely on the architecture. As systems with new libc based on 64-bit
> time_t are getting deployed, even architectures that previously supported
> these (notably x86-32 and arm32 but also many others) no longer depend on
> them, and removing them from a kernel image results in a smaller kernel
> binary, the same way we can leave out many other optional system calls.
> 
> More importantly, on an embedded system that needs to keep working
> beyond year 2038, any user space program calling these system calls
> is likely a bug, so removing them from the kernel image does provide
> an extra debugging help for finding broken applications.
> 
> I've gone back and forth on hiding this option unless CONFIG_EXPERT
> is set. This version leaves it visible based on the logic that
> eventually it will be turned off indefinitely.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
