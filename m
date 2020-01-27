Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0ED14A188
	for <lists+linux-api@lfdr.de>; Mon, 27 Jan 2020 11:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgA0KNP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 05:13:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53989 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725990AbgA0KNP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 05:13:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580119994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3eMn17RIkjhZWdXI11z/nzEmY0l83qqIsrDzFkIcHmE=;
        b=Afo27jkAkm/KwHYbjKPWQxSy/wffIMHs2XrQagyTo/r2MBPdipd2OZ22dyGdacY6qHnZtZ
        JOKBOwjlvoDmOZecShrW5OANYyoJ2xgPojLCGmhkdZ24NmX2wyjLW6kUNYur7a32zD5ZAa
        kFQr/ClndIDnWuC1oLTB//bZr9oMu4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-otat74i7PyeH3lWd2IHtwA-1; Mon, 27 Jan 2020 05:13:10 -0500
X-MC-Unique: otat74i7PyeH3lWd2IHtwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CFA9107ACC7;
        Mon, 27 Jan 2020 10:13:08 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-227.str.redhat.com [10.33.192.227])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94D91863C0;
        Mon, 27 Jan 2020 10:13:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Subject: Re: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
References: <20200123014627.71720-1-bgeffon@google.com>
        <20200124190625.257659-1-bgeffon@google.com>
Date:   Mon, 27 Jan 2020 11:13:02 +0100
In-Reply-To: <20200124190625.257659-1-bgeffon@google.com> (Brian Geffon's
        message of "Fri, 24 Jan 2020 11:06:25 -0800")
Message-ID: <87imkxxl5d.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Brian Geffon:

> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.  If a userfaultfd was watching
> the source, it will continue to watch the new mapping.  For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
> also used. The final result is two equally sized VMAs where the
> destination contains the PTEs of the source.

What will be the protection flags of the source mapping?  Will they
remain unchanged?  Or PROT_NONE?

Thanks,
Florian

