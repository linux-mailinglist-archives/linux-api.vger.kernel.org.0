Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CFD2CDF1A
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 20:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgLCThU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 14:37:20 -0500
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:8404 "EHLO
        esa4.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgLCThU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 14:37:20 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 14:37:20 EST
IronPort-SDR: c5GQu1xkEhn8w8+YDEQYdRbJSxe5an2akUdHTSY1JJn2ByJ3naYEWgw2goiscJtnyRX6ijAXA7
 nF9WF7KT9PWvLDCK7gZqQs6p0U+GiKEiixucaRAiwXslWV1bpYNUwApvFuO9N/g+p4c1VzPNCR
 ihx/cfEkwfsRlyDfR1+uZQoDeQpoJ7iX4yUFg2mc68hnbJU7Tx9MrTypzds7YMT46VZQQ18cnE
 SV2gzU/FBPZCBSifKhsG3U3x2W+OzTFAgSc2Y2lI1G9RhBTu4ojcXd9drpMeTesfWjiLHZeAUK
 t4Q=
X-IronPort-AV: E=Sophos;i="5.78,390,1599552000"; 
   d="scan'208";a="55902945"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 03 Dec 2020 11:26:32 -0800
IronPort-SDR: XP3ZEQho3UqMx3BhYt1pQPTeKTRf5W8xIRihDvtCBy7QtU3tUhB7Phh67eaOt39ZLijARoJO73
 cBW5k8t56e6WIOt9w363v7E0h1PB4g96rULSv/vrukcnALazLbg9LMKxWVlqSItIB4K6zGmnTz
 u7XrTyVwuFlmYBhsHPoIow3V9+KfZOiXyj+S61ioyEUkHp2VYVyzHPEoMsmwD+WGYEjTfayuI0
 GzEBbFfSClbc3UwEsqiOgNjJiNBnBtWa04/aokI9hKNeV4uCNJjw9HpC2rb7Qk5jK+xs3yWoiY
 lis=
Date:   Thu, 3 Dec 2020 19:26:25 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Florian Weimer <fweimer@redhat.com>
CC:     Andy Lutomirski <luto@amacapital.net>,
        Topi Miettinen <toiwoton@gmail.com>,
        <linux-hardening@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso
 and stack
In-Reply-To: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.22.394.2012031918220.193081@digraph.polyomino.org.uk>
References: <e8c458fe-073b-2c4d-4d80-3637041c1485@gmail.com>        <05D72EA3-4862-4D80-82F5-9369834C3461@amacapital.net> <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 3 Dec 2020, Florian Weimer wrote:

> My knowledge of probability theory is quite limited, so I have to rely
> on simulations.  But I think you would see a 40 GiB gap somewhere for a
> 47-bit address space with 32K allocations, most of the time.  Which is
> not too bad.

This is very close to a Poisson process (if the number of small 
allocations being distributed independently in the address space is 
large), so the probability that any given gap is at least x times the mean 
gap is about exp(-x).

-- 
Joseph S. Myers
joseph@codesourcery.com
