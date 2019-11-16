Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28C3FEBCD
	for <lists+linux-api@lfdr.de>; Sat, 16 Nov 2019 12:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfKPLZg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 16 Nov 2019 06:25:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45185 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbfKPLZg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 16 Nov 2019 06:25:36 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iVwCh-0001hJ-05; Sat, 16 Nov 2019 12:25:23 +0100
Date:   Sat, 16 Nov 2019 12:25:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 01/12] Linux Random Number Generator
In-Reply-To: <2645285.kI0haNqfm4@positron.chronox.de>
Message-ID: <alpine.DEB.2.21.1911161216540.14348@nanos.tec.linutronix.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2787174.DQlWHN5GGo@positron.chronox.de> <2645285.kI0haNqfm4@positron.chronox.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-279224958-1573903523=:14348"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-279224958-1573903523=:14348
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 16 Nov 2019, Stephan Müller wrote:
> +/**
> + * Hot code path - Callback for interrupt handler
> + */
> +void add_interrupt_randomness(int irq, int irq_flags)
> +{
> +	lrng_time_process();
> +
> +	if (!lrng_pool_highres_timer()) {
> +		struct pt_regs *regs = get_irq_regs();
> +		static atomic_t reg_idx = ATOMIC_INIT(0);
> +		u64 ip;
> +
> +		lrng_pool_lfsr_u32(jiffies);
> +		lrng_pool_lfsr_u32(irq);
> +		lrng_pool_lfsr_u32(irq_flags);
> +
> +		if (regs) {
> +			u32 *ptr = (u32 *)regs;
> +			int reg_ptr = atomic_add_return_relaxed(1, &reg_idx);
> +			size_t n = (sizeof(struct pt_regs) / sizeof(u32));
> +
> +			ip = instruction_pointer(regs);
> +			lrng_pool_lfsr_u32(*(ptr + (reg_ptr % n)));
> +		} else
> +			ip = _RET_IP_;
> +
> +		lrng_pool_lfsr_u32(ip >> 32);
> +		lrng_pool_lfsr_u32(ip);
> +	}

Is there a way to avoid all that processing right in the interrupt hot
path and just store the raw data for later processing?

Thanks,

	tglx

     
--8323329-279224958-1573903523=:14348--
