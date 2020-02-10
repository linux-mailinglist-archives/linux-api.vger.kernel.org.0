Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C26A156D5F
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 02:21:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgBJBVm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 9 Feb 2020 20:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBJBVm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sun, 9 Feb 2020 20:21:42 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D3B320715;
        Mon, 10 Feb 2020 01:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581297701;
        bh=EMJSH/+fxbjqTriNCLnX9H5eLVo9MEbkL9v2d8yQXu4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2hRd4UkwzYaBQqxVNYTCBj2kHb/MDQuC9Z1fGcFA1UNI5fONtunwFEWo1E/c8p53I
         x8RQ1+fMTkPNgbpt730GyDZZuu2C6FBLpO4aoaYc5CHSArPmGPHQMQnWE06WL0iEgw
         GwhT9uL9PNhAYZhya/4hkVny40rFtHLljp5o8ANc=
Date:   Sun, 9 Feb 2020 17:21:40 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Brian Geffon <bgeffon@google.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
Message-Id: <20200209172140.aa60488e10e0408c4f74f11b@linux-foundation.org>
In-Reply-To: <20200207201856.46070-1-bgeffon@google.com>
References: <20200207201856.46070-1-bgeffon@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri,  7 Feb 2020 12:18:56 -0800 Brian Geffon <bgeffon@google.com> wrote:

> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call. =A0If a userfaultfd was watching
> the source, it will continue to watch the new mapping. =A0For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> a VMA you MUST use the MREMAP_MAYMOVE flag. The final result is two
> equally sized VMAs where the destination contains the PTEs of the source.
>=20
> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
>=20
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."

This seems useful and reasonably mature, so I'll queue it for
additional testing and shall await review feedback.

Could we please get some self-test code for this feature in
tools/testing/selftests/vm?  Perhaps in userfaultfd.c?

