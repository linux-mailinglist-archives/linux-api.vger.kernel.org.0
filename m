Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4208E8F2BC
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbfHOSD2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 14:03:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40508 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728500AbfHOSD2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 14:03:28 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyK5X-0002zv-Le; Thu, 15 Aug 2019 20:03:03 +0200
Date:   Thu, 15 Aug 2019 20:03:02 +0200 (CEST)
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
Subject: Re: [PATCHv6 25/36] vdso: Introduce vdso_static_branch_unlikely()
In-Reply-To: <20190815163836.2927-26-dima@arista.com>
Message-ID: <alpine.DEB.2.21.1908151956470.1908@nanos.tec.linutronix.de>
References: <20190815163836.2927-1-dima@arista.com> <20190815163836.2927-26-dima@arista.com>
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

> From: Andrei Vagin <avagin@gmail.com>
> 
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> 
> Addressing those problems, there are two versions of VDSO's .so:
> for host tasks (without any penalty) and for processes inside of time
> namespace with clk_to_ns() that subtracts offsets from host's time.
> 
> Introduce vdso_static_branch_unlikely(), which is similar to
> static_branch_unlikely(); alias it with timens_static_branch_unlikely()
> under CONFIG_TIME_NS.
> 
> The timens code in vdso will look like this:
> 
>    if (timens_static_branch_unlikely()) {
> 	   clk_to_ns(clk, ts);

Please name that clk_to_namespace(). _ns() is widely used for nanoseconds.

>    }
> 
> The version of vdso which is compiled from sources will never execute
> clk_to_ns(). And then we can patch the 'no-op' in the straight-line
> codepath with a 'jump' instruction to the out-of-line true branch and
> get the timens version of the vdso library.

Colour me confused. Why do we need that static branch at all?

Why don't we compile VDSO_NO_NAMESPACE and VDSO_NAMESPACE right away? One
has the clk_to_namespace() one does not. The you can spare the whole static
key patching and the NO_NAMESPACE variant does not have extra 5 NOPS.

The VDSO is one page IIRC, so having the extra namespace variant around
does really not matter at all.

Thanks,

	tglx


