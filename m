Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB87F14DA84
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 13:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgA3MT4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 07:19:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59759 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgA3MTz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jan 2020 07:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580386795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Xqdu8J6TOj9He6qQ+BqrK7qHeGQ1dIibFBQ/FqCh1s=;
        b=PWfIzPm7Q7SLSRSG6qOPpqCGXSPa46OW7DCsJcgmIGBo/WvIbDdX9imQuJpKaKHhME5SfT
        0rm5ogSyDtg8EnzSG6vmzBtMKfYFN7bzK/ENdbux3clJi5HUhU/qIief+sLtSOzCTiH0yL
        +gUbIrRPJ2AGm5vyr/9zE2H/M5woZRs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-n6jIJxsQONivvhbjyMM1Ng-1; Thu, 30 Jan 2020 07:19:51 -0500
X-MC-Unique: n6jIJxsQONivvhbjyMM1Ng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94C6D8010EE;
        Thu, 30 Jan 2020 12:19:49 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-29.ams2.redhat.com [10.36.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 967175DA75;
        Thu, 30 Jan 2020 12:19:41 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
References: <20200123014627.71720-1-bgeffon@google.com>
        <20200124190625.257659-1-bgeffon@google.com>
        <87imkxxl5d.fsf@oldenburg2.str.redhat.com>
        <CADyq12xCpTzLpYC16FjnM60tHhCfnccNfg6JJuqcBd_6ACDGcQ@mail.gmail.com>
Date:   Thu, 30 Jan 2020 13:19:39 +0100
In-Reply-To: <CADyq12xCpTzLpYC16FjnM60tHhCfnccNfg6JJuqcBd_6ACDGcQ@mail.gmail.com>
        (Brian Geffon's message of "Mon, 27 Jan 2020 14:33:44 -0800")
Message-ID: <87eevh3zms.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Brian Geffon:

> Hi Florian,
> copy_vma will make a copy of the existing VMA leaving the old VMA
> unchanged, so the source keeps its existing protections, this is what
> makes it very useful along with userfaultfd.

I see.  On the other hand, it's impossible to get the PROT_NONE behavior
by a subsequent mprotect call because the mremap has to fail in some
cases in vm.overcommit_memory=2 mode.  But maybe that other behavior can
be provided with a different flag if it turns out to be useful in the
future.

Thanks,
Florian

