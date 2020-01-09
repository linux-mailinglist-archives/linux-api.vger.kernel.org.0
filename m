Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD37D13623E
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2020 22:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbgAIVJu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jan 2020 16:09:50 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55760 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVJu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 16:09:50 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipf3b-0008TG-8P; Thu, 09 Jan 2020 22:09:31 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B0803105BCE; Thu,  9 Jan 2020 22:09:30 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        crml <criu@openvz.org>, Linux API <linux-api@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCHv8 00/34] kernel: Introduce Time Namespace
In-Reply-To: <CAJwJo6ahGVHHgwFsPyjbY1PgmHs+D+A2Cma03ogvQGr+mPqYAw@mail.gmail.com>
References: <20191112012724.250792-1-dima@arista.com> <20191121180555.GA440967@gmail.com> <CAJwJo6ahGVHHgwFsPyjbY1PgmHs+D+A2Cma03ogvQGr+mPqYAw@mail.gmail.com>
Date:   Thu, 09 Jan 2020 22:09:30 +0100
Message-ID: <87y2ug9w1h.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dmitry Safonov <0x7f454c46@gmail.com> writes:

> Gentle ping, in case you have time to look at this.

I'm looking at it and so far I'm quite happy.

Andy, Vincenco any opinions?

Thanks,

        tglx
