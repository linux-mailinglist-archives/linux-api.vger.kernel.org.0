Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B1B8FB24
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 08:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfHPGgs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 02:36:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfHPGgs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 02:36:48 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyVqg-0003Nx-Bc; Fri, 16 Aug 2019 08:36:30 +0200
Date:   Fri, 16 Aug 2019 08:36:29 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv6 28/36] posix-clocks: Add align for timens_offsets
In-Reply-To: <alpine.DEB.2.21.1908152010230.1908@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908160835130.1908@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-29-dima@arista.com> <alpine.DEB.2.21.1908152010230.1908@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 15 Aug 2019, Thomas Gleixner wrote:
> So using struct timespec64 for the offset is wrong. You really need to open
> code that offset storage if you don't want to end up with weird workarounds
> for BE.
> 
> Something like this:
> 
> struct timens_offs {
> 	  time64_t	tv_sec;
> 	  s64		tv_nsec;

Actually that should use 'int' for the tv_nsec part.

Thanks,

	tglx
