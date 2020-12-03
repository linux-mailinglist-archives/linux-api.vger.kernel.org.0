Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8658A2CDC63
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 18:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgLCRae (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 12:30:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728855AbgLCRad (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 12:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607016547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkos210NIFS1skhYbtLm+7Un9gIxTlS4wm4FQwNPr0c=;
        b=cfp37yNgd20hH6AtHkwiiMPabVoj9uwhfADzyfEwjLOj8T4tJxnThdnsJGwGgfL6cvJFFJ
        B1VMZ25MKDz/kHJ0jEpP4NgK0fUTCf4nxA1YzOO4snQf1IWQZs8+G+bRXf0QnxzIMuBMYO
        8hyjeDpeGNra8g52vJwo5wj8VJhWVjs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-Cx-QqieHNP67GrLlF9BScA-1; Thu, 03 Dec 2020 12:29:03 -0500
X-MC-Unique: Cx-QqieHNP67GrLlF9BScA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7124F107ACE6;
        Thu,  3 Dec 2020 17:29:01 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-44.ams2.redhat.com [10.36.112.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 117121349A;
        Thu,  3 Dec 2020 17:28:58 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso
 and stack
References: <e8c458fe-073b-2c4d-4d80-3637041c1485@gmail.com>
        <05D72EA3-4862-4D80-82F5-9369834C3461@amacapital.net>
Date:   Thu, 03 Dec 2020 18:28:57 +0100
In-Reply-To: <05D72EA3-4862-4D80-82F5-9369834C3461@amacapital.net> (Andy
        Lutomirski's message of "Thu, 3 Dec 2020 09:10:32 -0800")
Message-ID: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Andy Lutomirski:

> If you want a 4GB allocation to succeed, you can only divide the
> address space into 32k fragments.  Or, a little more precisely, if you
> want a randomly selected 4GB region to be empty, any other allocation
> has a 1/32k chance of being in the way.  (Rough numbers =E2=80=94 I=E2=80=
=99m ignoring
> effects of the beginning and end of the address space, and I=E2=80=99m
> ignoring the size of a potential conflicting allocation.).

I think the probability distribution is way more advantageous than that
because it is unlikely that 32K allocations are all exactly spaced 4 GB
apart.  (And with 32K allocations, you are close to the VMA limit anyway.)

My knowledge of probability theory is quite limited, so I have to rely
on simulations.  But I think you would see a 40 GiB gap somewhere for a
47-bit address space with 32K allocations, most of the time.  Which is
not too bad.

But even with a 47 bit address space and just 500 threads (each with at
least a stack and local heap, randomized indepently), simulations
suggestion that the largest gap is often just 850 GB.  At that point,
you can't expect to map your NVDIMM (or whatever) in a single mapping
anymore, and you have to code around that.

Not randomizing large allocations and sacrificing one bit of randomness
for small allocations would avoid this issue, though.

(I still expect page walking performance to suffer drastically, with or
without this tweak.  I assume page walking uses the CPU cache hierarchy
today, and with full randomization, accessing page entry at each level
after a TLB miss would result in a data cache miss.  But then, I'm
firmly a software person.)

Thanks,
Florian
--=20
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'N=
eill

