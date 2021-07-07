Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606443BE5CD
	for <lists+linux-api@lfdr.de>; Wed,  7 Jul 2021 11:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhGGJtl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Jul 2021 05:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230429AbhGGJtk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Jul 2021 05:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625651220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cRhesyWUivXLxczgsLtk6gE/w390EMKhBeqxLadHP1U=;
        b=cnq7KrKpY0Wkovv5o3+Hd5/ef8gLK0x9OQ4PPcptpXSt/lANXZj0vh5aba23r5uW/9u+VH
        dMnK0JhBeLbkVxnZWbjZVnKVkSWz5EIrp17bgDBDOOLJCfSD964otyja9CheZBiK4GBZ3I
        dS8f9Xc/KCj+65nVKIyBrpbYBbl2z5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-LC5DqymDMWaVfVngzz1ueg-1; Wed, 07 Jul 2021 05:46:58 -0400
X-MC-Unique: LC5DqymDMWaVfVngzz1ueg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37D34804140;
        Wed,  7 Jul 2021 09:46:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-115-5.ams2.redhat.com [10.36.115.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0C9319C44;
        Wed,  7 Jul 2021 09:46:43 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
        rientjes@google.com, willy@infradead.org, hannes@cmpxchg.org,
        guro@fb.com, riel@surriel.com, minchan@kernel.org,
        christian@brauner.io, hch@infradead.org, oleg@redhat.com,
        david@redhat.com, jannh@google.com, shakeelb@google.com,
        timmurray@google.com, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
References: <20210623192822.3072029-1-surenb@google.com>
Date:   Wed, 07 Jul 2021 11:46:42 +0200
In-Reply-To: <20210623192822.3072029-1-surenb@google.com> (Suren
        Baghdasaryan's message of "Wed, 23 Jun 2021 12:28:22 -0700")
Message-ID: <87sg0qa22l.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Suren Baghdasaryan:

> The API is as follows,
>
>           int process_reap(int pidfd, unsigned int flags);
>
>         DESCRIPTION
>           The process_reap() system call is used to free the memory of a
>           dying process.
>
>           The pidfd selects the process referred to by the PID file
>           descriptor.
>           (See pidofd_open(2) for further information)
>
>           The flags argument is reserved for future use; currently, this
>           argument must be specified as 0.
>
>         RETURN VALUE
>           On success, process_reap() returns 0. On error, -1 is returned
>           and errno is set to indicate the error.

I think the manual page should mention what it means for a process to be
=E2=80=9Cdying=E2=80=9D, and how to move a process to this state.

Thanks,
Florian

