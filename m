Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 207498F219
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbfHORYr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 13:24:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40352 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730282AbfHORYr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 13:24:47 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyJU7-0002Js-7e; Thu, 15 Aug 2019 19:24:23 +0200
Date:   Thu, 15 Aug 2019 19:24:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: Re: [PATCHv6 03/36] posix-clocks: Rename the clock_get() into
 clock_get_timespec()
In-Reply-To: <20190815163836.2927-4-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1908151922430.1908@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-4-dima@arista.com>
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

On Thu, 15 Aug 2019, Dmitry Safonov wrote:

Just a nit vs. the subject line:

posix-clocks: Rename the clock_get() callback to clock_get_timespec()

> From: Andrei Vagin <avagin@gmail.com>
> 
> The upcoming support for time namespaces requires to have access to:
>  - The time in a task's time namespace for sys_clock_gettime()
>  - The time in the root name space for common_timer_get()
> 
> That adds a valid reason to finally implement a separate callback which
> returns the time in ktime_t format, rather than in (struct timespec).
> 
> Rename clock_get() callback into clock_get_timespec() as a preparation

s/clock_get()/the clock_get()/
s/into/to/

> for introducing clock_get_ktime().

Otherwise this looks fine.

Thanks,

	tglx
