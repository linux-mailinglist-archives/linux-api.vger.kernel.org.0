Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4740427160B
	for <lists+linux-api@lfdr.de>; Sun, 20 Sep 2020 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgITQuv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 20 Sep 2020 12:50:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:27719 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgITQuv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 20 Sep 2020 12:50:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1600620646;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OLR7KLlF/JzCb7U35Y0Ov3zt4ftoGTUVmg0q5c2S7X8=;
        b=AXFBj5iFdqqm2RyFxhGonh9KuIog7gpzd7oaPSl1w8CkWElzaVeCsBCICZ+z+XMJeG
        7hhZLAm+6EPVdJX9KWP4wZqCOtWI3wwtY6fOU+bXUu1iU/JtPtzYfG14W+49PKHPs2+u
        chCNqeEc0xVwmsJmUyiHFv6Ox9ap6wzNP+45tpLrPsaq/MTryqW6yrGB/qYAtBit9Xl5
        S2V6Zi6z1Z2zMU8ZigqgIWgg3W8qVZbHVquuI4cwGTu0M637bJN7B0RygsU+9WCYxeDe
        TIDTSQhvz4WjbwbEep4lv9kp/ZQnuRs2mAYXQvujn1aOd52pOMt4ltHviU2VGrALvpnk
        aJ/Q==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbI/Sa6ro="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id 002e9aw8KGnwCmn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Sun, 20 Sep 2020 18:49:58 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v35 01/13] Linux Random Number Generator
Date:   Sun, 20 Sep 2020 18:49:57 +0200
Message-ID: <4146830.tdWV9SEqCh@tauon.chronox.de>
In-Reply-To: <202009182001.I8MjZZ8x%lkp@intel.com>
References: <4288186.LvFx2qVVIh@positron.chronox.de> <202009182001.I8MjZZ8x%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Freitag, 18. September 2020, 15:02:17 CEST schrieb kernel test robot:

Hi,

> All errors (new ones prefixed by >>):
> >> drivers/char/lrng/lrng_chacha20.c:33:8: error: structure variable
> >> 'chacha20' with 'latent_entropy' attribute has a non-integer field
> >> 'block'
>       33 | struct chacha20_state chacha20 __latent_entropy;
> 
>          |        ^~~~~~~~~~~~~~
> 
> #
> https://github.com/0day-ci/linux/commit/ecb964754fd80cca434d6d2ad6db8f28a15
> 92fa1 git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review
> Stephan-M-ller/dev-random-a-new-approach/20200918-181505 git checkout
> ecb964754fd80cca434d6d2ad6db8f28a1592fa1
> vim +33 drivers/char/lrng/lrng_chacha20.c
> 
>     27
>     28	/*
>     29	 * Have a static memory blocks for the ChaCha20 DRNG instance to
> avoid calling 30	 * kmalloc too early in the boot cycle. For 
subsequent
> allocation requests, 31	 * such as per-NUMA-node DRNG instances, 
kmalloc
> will be used. 32	 */
> 
>   > 33	struct chacha20_state chacha20 __latent_entropy;

I do not think this report is valid. The following definitions apply:

struct chacha20_state {
        struct chacha20_block block;
};

struct chacha20_block {
        u32 constants[4];
        union {
#define CHACHA_KEY_SIZE_WORDS (CHACHA_KEY_SIZE / sizeof(u32))
                u32 u[CHACHA_KEY_SIZE_WORDS];
                u8  b[CHACHA_KEY_SIZE];
        } key;
        u32 counter;
        u32 nonce[3];
};


This implies that struct chacha20_state and thus the chacha20 variable is a 
linear buffer with in total 4 + 8 + 1 + 3  = 16 32-bit integers which are at 
least aligned on a 32-bit boundary and are designated as u32 integers.

Please let me know if I need to make a tweak to the definitions to convince 
the code analyzer it is a flat linear buffer consisting of integers and thus 
to understand the structure correctly.

Thanks a lot.

Ciao
Stephan


