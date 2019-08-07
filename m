Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5D84443
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 08:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfHGGHy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 02:07:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47778 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfHGGHy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 02:07:54 -0400
Received: from p200300ddd742df588d2c07822b9f4274.dip0.t-ipconnect.de ([2003:dd:d742:df58:8d2c:782:2b9f:4274])
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hvF6k-0006jZ-QN; Wed, 07 Aug 2019 08:07:34 +0200
Date:   Wed, 7 Aug 2019 08:07:28 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <dima@arista.com>
cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: Re: [PATCHv5 09/37] posix-clocks: Introduce CLOCK_MONOTONIC time
 namespace offsets
In-Reply-To: <20190729215758.28405-10-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1908070805460.24014@nanos.tec.linutronix.de>
References: <20190729215758.28405-1-dima@arista.com> <20190729215758.28405-10-dima@arista.com>
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

On Mon, 29 Jul 2019, Dmitry Safonov wrote:
>  
> +static inline void timens_add_monotonic(struct timespec64 *ts)
> +{
> +	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> +
> +	if (ns_offsets)
> +		*ts = timespec64_add(*ts, ns_offsets->monotonic);
> +}

This helper is not posix timer specific and should be introduced either in
the name space patches or in a separate patch,

Thanks

	tglx
