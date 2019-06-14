Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83CEF46048
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfFNONy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 10:13:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38272 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbfFNONy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 10:13:54 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hbmxQ-0007Cp-4N; Fri, 14 Jun 2019 16:13:32 +0200
Date:   Fri, 14 Jun 2019 16:13:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCHv4 26/28] x86/vdso: Align VDSO functions by CPU L1 cache
 line
In-Reply-To: <20190612192628.23797-27-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1906141610060.1722@nanos.tec.linutronix.de>
References: <20190612192628.23797-1-dima@arista.com> <20190612192628.23797-27-dima@arista.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 12 Jun 2019, Dmitry Safonov wrote:

> From: Andrei Vagin <avagin@gmail.com>
> 
> After performance testing VDSO patches a noticeable 20% regression was
> found on gettime_perf selftest with a cold cache.
> As it turns to be, before time namespaces introduction, VDSO functions
> were quite aligned to cache lines, but adding a new code to adjust
> timens offset inside namespace created a small shift and vdso functions
> become unaligned on cache lines.
> 
> Add align to vdso functions with gcc option to fix performance drop.
> 
> Coping the resulting numbers from cover letter:
> 
> Hot CPU cache (more gettime_perf.c cycles - the better):
>         | before     | CONFIG_TIME_NS=n | host        | inside timens
> --------|------------|------------------|-------------|-------------
> cycles  | 139887013  | 139453003        | 139899785   | 128792458
> diff (%)| 100        | 99.7             | 100         | 92

Why is CONFIG_TIME_NS=n behaving worse than current mainline and
worse than 'host' mode?

> Cold cache (lesser tsc per gettime_perf_cold.c cycle - the better):
>         | before     | CONFIG_TIME_NS=n | host        | inside timens
> --------|------------|------------------|-------------|-------------
> tsc     | 6748       | 6718             | 6862        | 12682
> diff (%)| 100        | 99.6             | 101.7       | 188

Weird, now CONFIG_TIME_NS=n is better than current mainline and 'host' mode
drops.

Either I'm misreading the numbers or missing something or I'm just confused
as usual :)

Thanks,

	tglx
