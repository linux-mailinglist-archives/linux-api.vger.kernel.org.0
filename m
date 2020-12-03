Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625692CDC9B
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 18:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgLCRnh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 12:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgLCRng (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 12:43:36 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9BC061A51
        for <linux-api@vger.kernel.org>; Thu,  3 Dec 2020 09:42:56 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id s2so1538038plr.9
        for <linux-api@vger.kernel.org>; Thu, 03 Dec 2020 09:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ewjsiW9xOOWwJ7Vn/ikJbHYwHfnQIPjHGmHGP7oi6BE=;
        b=O5IvV2/Vubx9BfUcRWT56D/4/JIWhi2M8/1ywP+fGkSzRHslO0wfwe5e4AJ20Fh8o2
         ZA2L7P1NHqA9iifsGKNv9sCbPp1F8AstH9lDyxvpAR1A5yyA8wnjVphnmkjfrkCLGoss
         gaU7CyuMjRpNB6n727nzPwwvdMJ/8ysb9w4X2H7kY+mjl4D3NcDTQ1FgQY2xRKkTYUle
         KIHSm8/RIpmAJTPsNZE2wXzuzgpkgowncocmXUFidgDul2mI5+Mj9Z2g1fXa2FjAGyPH
         kSfsJh5orSF+cvzkyIuSWOLcYWAkPpUEdJCWwP6mAqgeTwXUzrjumKm0iCHDkePCxP/U
         AtVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ewjsiW9xOOWwJ7Vn/ikJbHYwHfnQIPjHGmHGP7oi6BE=;
        b=emdsRDFR6m5XF5qzArId29jomLwNPkiYFIBhz1yNzTqCSiz1wZqmzseXfdzf6xm0cP
         eT8a43Zgu6Lq8lbHlgfxfe0urnmDm64Y3e5MFTyLyxwph+iXNPASjEF/YLX5DRJMl9tA
         L6pT40smHfIexoDKCv+MUAVEt5R3It2KMgMKjhkr6klFpBJtr1UqKZy5CTEEXdBkQ5Wo
         /eO0vWhBZm7L5558XerAKbw/wyw5m9pokMO1R8yDV9K4ohqNSiEUUReVUSvuLm0aYvC+
         8e2W1CIKBDx27rBjbNW2rdSmbQE9qrsbxzwuo2X67onfdxi8xWE7ex433QuJQ1Hz11R6
         VDsw==
X-Gm-Message-State: AOAM530N1zzbCNacXDwmmsYS6iEwZcu7zATi/JDnGk2H9lE5SgU4eRwa
        JdxziwDcVGcIELU+awOobPvKMg==
X-Google-Smtp-Source: ABdhPJzTpCbbRfGOWHG7m+mZZhYM+XYEslxM55n+IwQtflCINDXZDUjStV6j4JnVJwJcZsivKclnxQ==
X-Received: by 2002:a17:90b:50e:: with SMTP id r14mr237250pjz.90.1607017376213;
        Thu, 03 Dec 2020 09:42:56 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:8949:f4fe:cc16:86da? ([2601:646:c200:1ef2:8949:f4fe:cc16:86da])
        by smtp.gmail.com with ESMTPSA id j11sm1655038pgp.82.2020.12.03.09.42.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 09:42:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso and stack
Date:   Thu, 3 Dec 2020 09:42:54 -0800
Message-Id: <1CB9B4D1-1E32-42DC-A4E9-6E53C85365BF@amacapital.net>
References: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
In-Reply-To: <871rg6yf1i.fsf@oldenburg2.str.redhat.com>
To:     Florian Weimer <fweimer@redhat.com>
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


> On Dec 3, 2020, at 9:29 AM, Florian Weimer <fweimer@redhat.com> wrote:
>=20
> =EF=BB=BF* Andy Lutomirski:
>=20
>> If you want a 4GB allocation to succeed, you can only divide the
>> address space into 32k fragments.  Or, a little more precisely, if you
>> want a randomly selected 4GB region to be empty, any other allocation
>> has a 1/32k chance of being in the way.  (Rough numbers =E2=80=94 I=E2=80=
=99m ignoring
>> effects of the beginning and end of the address space, and I=E2=80=99m
>> ignoring the size of a potential conflicting allocation.).
>=20
> I think the probability distribution is way more advantageous than that
> because it is unlikely that 32K allocations are all exactly spaced 4 GB
> apart.  (And with 32K allocations, you are close to the VMA limit anyway.)=


I=E2=80=99m assuming the naive algorithm of choosing an address and trying i=
t.  Actually looking for a big enough gap would be more reliable.

I suspect that something much more clever could be done in which the heap is=
 divided up into a few independently randomized sections and heap pages are r=
andomized within the sections might do much better. There should certainly b=
e a lot of room for something between what we have now and a fully randomize=
d scheme.

It might also be worth looking at what other OSes do.=
