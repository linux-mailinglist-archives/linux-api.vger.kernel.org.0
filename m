Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783E42CD2DE
	for <lists+linux-api@lfdr.de>; Thu,  3 Dec 2020 10:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgLCJt1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Dec 2020 04:49:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728962AbgLCJt0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Dec 2020 04:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606988880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IMWz2J6ee0z3Goxs//cxHMcur+NB7NXymG3FsD4KqVk=;
        b=SFn3gr204Ehl5xY6H0alRjOYuRZgSJihU6EkjbhSdxRVaHKTBd165rU1RSlJzoseUpppc7
        HkRLvS7HOWyPHEgm0RTkZf5zIm+duL1+45sEBof4GUdDK++uODisI8auUmQ28/Gvb1woAT
        XLHf1UiG4qMDi8rxuPvKUuvZ3OKDcQk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-KooIkbC-OxyfPReSet9BCw-1; Thu, 03 Dec 2020 04:47:56 -0500
X-MC-Unique: KooIkbC-OxyfPReSet9BCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7315708A;
        Thu,  3 Dec 2020 09:47:55 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-44.ams2.redhat.com [10.36.112.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E505D75F;
        Thu,  3 Dec 2020 09:47:52 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v5] mm: Optional full ASLR for mmap(), mremap(), vdso
 and stack
References: <20201129211517.2208-1-toiwoton@gmail.com>
Date:   Thu, 03 Dec 2020 10:47:51 +0100
In-Reply-To: <20201129211517.2208-1-toiwoton@gmail.com> (Topi Miettinen's
        message of "Sun, 29 Nov 2020 23:15:17 +0200")
Message-ID: <87im9j2pbs.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Topi Miettinen:

> +3   Additionally enable full randomization of memory mappings created
> +    with mmap(NULL, ...). With 2, the base of the VMA used for such
> +    mappings is random, but the mappings are created in predictable
> +    places within the VMA and in sequential order. With 3, new VMAs
> +    are created to fully randomize the mappings.
> +
> +    Also mremap(..., MREMAP_MAYMOVE) will move the mappings even if
> +    not necessary and the location of stack and vdso are also
> +    randomized.
> +
> +    On 32 bit systems this may cause problems due to increased VM
> +    fragmentation if the address space gets crowded.

Isn't this a bit of an understatement?  I think you'll have to restrict
this randomization to a subregion of the entire address space, otherwise
the reduction in maximum mapping size due to fragmentation will be a
problem on 64-bit architectures as well (which generally do not support
the full 64 bits for user-space addresses).

> +    On all systems, it will reduce performance and increase memory
> +    usage due to less efficient use of page tables and inability to
> +    merge adjacent VMAs with compatible attributes. In the worst case,
> +    additional page table entries of up to 4 pages are created for
> +    each mapping, so with small mappings there's considerable penalty.

The number 4 is architecture-specific, right?

Thanks,
Florian
-- 
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill

