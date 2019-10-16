Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A76E6D9504
	for <lists+linux-api@lfdr.de>; Wed, 16 Oct 2019 17:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392646AbfJPPHc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 16 Oct 2019 11:07:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50545 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfJPPHb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 16 Oct 2019 11:07:31 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iKktN-0007P5-O1; Wed, 16 Oct 2019 17:07:13 +0200
Date:   Wed, 16 Oct 2019 17:07:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
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
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCHv7 19/33] lib/vdso: Prepare for time namespace support
In-Reply-To: <a726e64f-bf73-4eca-6acf-75926898d88a@arm.com>
Message-ID: <alpine.DEB.2.21.1910161704120.2046@nanos.tec.linutronix.de>
References: <20191011012341.846266-1-dima@arista.com> <20191011012341.846266-20-dima@arista.com> <a726e64f-bf73-4eca-6acf-75926898d88a@arm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 16 Oct 2019, Vincenzo Frascino wrote:

< SNIP >

> > --- a/lib/vdso/Kconfig
> > +++ b/lib/vdso/Kconfig
> > @@ -24,4 +24,10 @@ config GENERIC_COMPAT_VDSO
> >  	help
> >  	  This config option enables the compat VDSO layer.
> >  
> > +config VDSO_TIMENS
> 
> To uniform the naming with the rest of the file and with CONFIG_TIME_NS, can we
> please change the name of this config option in GENERIC_VDSO_TIME_NS? And then
> follow the logic explained by Thomas in patch 1 of this series.

Can you pretty please finally start to trim your replies?

If you didn't read the link I sent you earlier, then here is the relevant
paragraph:

  It's an annoyance to have to scroll down through several pages of quoted
  text to find a single line of reply or to figure out that after that
  reply the rest of the e-mail is just useless ballast.

I know that corporate mail style does not care about that, but I pretty
much care.

Thanks,

	tglx
