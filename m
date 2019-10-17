Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89298DA83A
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2019 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393685AbfJQJZS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 17 Oct 2019 05:25:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52436 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732676AbfJQJZS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 17 Oct 2019 05:25:18 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL21W-0004XC-HS; Thu, 17 Oct 2019 11:24:51 +0200
Date:   Thu, 17 Oct 2019 11:24:45 +0200 (CEST)
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCHv7 00/33] kernel: Introduce Time Namespace
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1910171122030.1824@nanos.tec.linutronix.de>
References: <20191011012341.846266-1-dima@arista.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 11 Oct 2019, Dmitry Safonov wrote:
> We wrote two small benchmarks. The first one gettime_perf.c calls
> clock_gettime() in a loop for 3 seconds. It shows us performance with
> a hot CPU cache (more clock_gettime() cycles - the better):
> 
>         | before    | CONFIG_TIME_NS=n | host      | inside timens
> --------------------------------------------------------------
>         | 153242367 | 153567617        | 150933203 | 139310914
>         | 153324800 | 153115132        | 150919828 | 139299761
>         | 153125401 | 153686868        | 150930471 | 139273917
>         | 153399355 | 153694866        | 151083410 | 139286081
>         | 153489417 | 153739716        | 150997262 | 139146403
>         | 153494270 | 153724332        | 150035651 | 138835612
> -----------------------------------------------------------
> avg     | 153345935 | 153588088        | 150816637 | 139192114
> diff %  | 100       | 100.1            | 98.3      | 90.7


That host 98.3% number is weird and does not match the tests I did with the
fallback code I provided you. On my limited testing that fallback hidden in
the slowpath did not show any difference to the TIME_NS=n case when not
inside a time namespace.

Thanks,

	tglx
