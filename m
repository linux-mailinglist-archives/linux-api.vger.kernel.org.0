Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B77AA1460D8
	for <lists+linux-api@lfdr.de>; Thu, 23 Jan 2020 04:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgAWDCM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 22:02:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37057 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgAWDCM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 22:02:12 -0500
Received: by mail-pl1-f196.google.com with SMTP id c23so702573plz.4
        for <linux-api@vger.kernel.org>; Wed, 22 Jan 2020 19:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QHwD3xJbxA6Bj+Yx1EYQsUkr/yHSHTopSLaHf+HB1LQ=;
        b=J6gYOfoWW7D94l0Y7ebAoY3D9qsp2ivY4bRoViRNM2t+ygjSQ7c98hfo1U/XlqYySc
         JojfwPv88Mja6A6xQTlrtoPOT36SxrfCvfj3t5/EqQfJCxSo0NcL1czveIgtaa7lDe95
         L+vwHoDMjlgDTN7MvU7EIxsiGv1L9+qITCvUNfrbshL2PKCeiVc7vZB3qVeSzAkQSp+S
         8VGp43i/tm1uGMM+3zQEztlAgfEXgCGnbBuZ/2w1MEV7J62DVCLiS10G//0E58+SgMsx
         w946YabfAyizOwSP6vU1vxY35l/0xrrc1X+/j0QklraJ0iAJO6pkB3c74LgNhr3Brd1z
         5FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QHwD3xJbxA6Bj+Yx1EYQsUkr/yHSHTopSLaHf+HB1LQ=;
        b=c/eRklATtzPpCrGbMmeDweH2i+Ft5OZ7DkjsWcdHJW50YX+HFULIkfq0cr5uMRMpSk
         qbg3lGIeow6Z/H/J33qi7gpKzPSh7AQL+9SQKKytS2vkazKTJbbAaVOJc9CSMdirYh7n
         +aNKohk8dPII8t3RGJp6vFcd8jf8CT0ux1/T/274sPaoPzijxMV+CiJ+WV5IEdRaUuUA
         3+NlWVn6NIE02gOx5n6ptY7a60+P+U9J1KrpGBB5QVjofkdG3BnmMaAQGBdJCAY42Wot
         p2lWAZHvEg1Km6U+51pR+lo4I4I06O4OgCNXINlVk2QlN+5Vn7/dmKeYrryF5w+Qxm+1
         Xcbw==
X-Gm-Message-State: APjAAAXNyP1HiaBFzuCDzkTfeq2f2nAsV8YBixsci/ULA8sd8uCQ7Mc9
        yZzUKHlohoys51qaCWPKDH9q7Q==
X-Google-Smtp-Source: APXvYqx0ztp78PhfwAEOpZE9YOyLcEj6xDbpjw3B4QFYco9brX2bu9A5MvQuDHkORMpB6ZNtfDJ0aw==
X-Received: by 2002:a17:90a:5215:: with SMTP id v21mr2014316pjh.31.1579748532131;
        Wed, 22 Jan 2020 19:02:12 -0800 (PST)
Received: from ?IPv6:2600:1010:b025:c4e4:c9ce:11e3:9a9e:90f0? ([2600:1010:b025:c4e4:c9ce:11e3:9a9e:90f0])
        by smtp.gmail.com with ESMTPSA id y203sm312460pfb.65.2020.01.22.19.02.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 19:02:11 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: Add MREMAP_DONTUNMAP to mremap().
Date:   Wed, 22 Jan 2020 19:02:08 -0800
Message-Id: <CD5EA896-7364-40E2-8709-A014973FFBC8@amacapital.net>
References: <20200123014627.71720-1-bgeffon@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
In-Reply-To: <20200123014627.71720-1-bgeffon@google.com>
To:     Brian Geffon <bgeffon@google.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> On Jan 22, 2020, at 5:46 PM, Brian Geffon <bgeffon@google.com> wrote:
>=20
> =EF=BB=BFMREMAP_DONTUNMAP is an additional flag that can be used with
> MREMAP_FIXED to move a mapping to a new address. Normally, mremap(2)
> would then tear down the old vma so subsequent accesses to the vma
> cause a segfault. However, with this new flag it will keep the old
> vma with zapping PTEs so any access to the old VMA after that point
> will result in a pagefault.

This needs a vastly better description. Perhaps:

When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is set, th=
e source mapping will not be removed. Instead it will be cleared as if a bra=
nd new anonymous, private mapping had been created atomically as part of the=
 mremap() call.  If a userfaultfd was watching the source, it will continue t=
o watch the new mapping.  For a mapping that is shared or not anonymous, MRE=
MAP_DONTUNMAP will cause the mremap() call to fail.

Or is it something else?

>=20
> This feature will find a use in ChromeOS along with userfaultfd.
> Specifically we will want to register a VMA with userfaultfd and then
> pull it out from under a running process. By using MREMAP_DONTUNMAP we
> don't have to worry about mprotecting and then potentially racing with
> VMA permission changes from a running process.

Does this mean you yank it out but you want to replace it simultaneously?

>=20
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical=

> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming=

> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."

Cute.=
