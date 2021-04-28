Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BB036DE29
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbhD1RYc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Apr 2021 13:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25356 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231339AbhD1RYc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Apr 2021 13:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619630626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QmxbNDcfkmoT4snx6gLW6zB0uLTOmzBgWbCGZ43h/M=;
        b=ZzCrrHdOP4mJDOUxSO+4Q35NSCs/UVzEYL0+E6A4nwVXZlJ3jlcbDT7BXrCRtifO+UwYBe
        oUzyQIbHta8wd7OyV16gwsMtsOREU/xhaIFfPvaCeQHes5mm/mb0i8gCVQ0rHTXmzV/i8l
        I7VqYah1c3/+dw0KoR+yIYo+LJG8uTU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-bFqNYILFNXe3b8zyxttzEg-1; Wed, 28 Apr 2021 13:23:44 -0400
X-MC-Unique: bFqNYILFNXe3b8zyxttzEg-1
Received: by mail-qv1-f71.google.com with SMTP id h12-20020a0cf44c0000b02901c0e9c3e1d0so1292615qvm.4
        for <linux-api@vger.kernel.org>; Wed, 28 Apr 2021 10:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6QmxbNDcfkmoT4snx6gLW6zB0uLTOmzBgWbCGZ43h/M=;
        b=eXXlO0x/oiRuRmpFLVq8dd7W8IPxEZPTI/fsJ26W+sttSGc7r78y7kIw0z/RMCEpbd
         xrhjeWZJJe4sx/PScbwefThSvJnisnUhFlpAOF5gILES9FAQGT3K4lUJU2usbFriA8i9
         maIjogOr/XMFZ9TA/w+UxjReYg2BE4RI8NrjV+o4MBXLTMdIN4zP1qyL5kmPU63IluIF
         2HqDSAGHGIxsrwbkxN7TKmHvS7UhK5eP7VEWwb9MDBqC3mKpLyfXFgOFqli6TEvEObfe
         4XnrzDXlSgu9M5ArNHnDNZiVv4lG5XX803092olINYbB1ERiBC+7LFBNf/qxLUDUEqlr
         n/mQ==
X-Gm-Message-State: AOAM533a6PL9tle83nkA8lhtcd2Z72fDVtSDapAeYU0JGI8G06yc+k9R
        9c7zzTsCwhbgLuPPXWl14HkkZg46CxtlCEBNn6TLavawcukCAolDiNzlWXEwvk7zmUUX0FpxZ8G
        m+vKjRk0ZRH+qdUTk7aBr
X-Received: by 2002:ae9:f310:: with SMTP id p16mr29914944qkg.123.1619630624369;
        Wed, 28 Apr 2021 10:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJweTpfhxOs2+FE7b/y38FVRdocxBBDoCy0Saro4x4l/ivnG64cNuM5i6194baTUbY8T8h2pWw==
X-Received: by 2002:ae9:f310:: with SMTP id p16mr29914911qkg.123.1619630624022;
        Wed, 28 Apr 2021 10:23:44 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 198sm275365qkf.20.2021.04.28.10.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 10:23:43 -0700 (PDT)
Date:   Wed, 28 Apr 2021 13:23:41 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 09/10] userfaultfd/selftests: reinitialize test
 context in each test
Message-ID: <20210428172341.GF6584@xz-x1>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-10-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-10-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 27, 2021 at 03:52:43PM -0700, Axel Rasmussen wrote:
> Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
> mutates this state in some way, in some cases really "clobbering it"
> (e.g., the events test mremap-ing area_dst over the top of area_src, or
> the minor faults tests overwriting the count_verify values in the test
> areas). We run the tests in a particular order, each test is careful to
> make the right assumptions about its starting state, etc.
> 
> But, this is fragile. It's better for a test's success or failure to not
> depend on what some other prior test case did to the global state.
> 
> To that end, clear and reinitialize the test context at the start of
> each test case, so whatever prior test cases did doesn't affect future
> tests.
> 
> This is particularly relevant to this series because the events test's
> mremap of area_dst screws up assumptions the minor fault test was
> relying on. This wasn't a problem for hugetlb, as we don't mremap in
> that case.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

