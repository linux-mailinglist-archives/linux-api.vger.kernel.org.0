Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 967533BF137
	for <lists+linux-api@lfdr.de>; Wed,  7 Jul 2021 23:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhGGVKI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Jul 2021 17:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhGGVKI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Jul 2021 17:10:08 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F77C06175F
        for <linux-api@vger.kernel.org>; Wed,  7 Jul 2021 14:07:27 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id r132so5368973yba.5
        for <linux-api@vger.kernel.org>; Wed, 07 Jul 2021 14:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aWzEI8RIsIrge+Ik0HeT8Rj/B4/rdob6KSKbIm3ow38=;
        b=G2dTceXudrWKc33/bGZBuAZbtX51Pj+2wKWVk8gxp1kvWtNW/d7M7lvbb8SX5JZl4k
         j2rh++vdPnZJtl3wEV3THrt9aEazho5gCYRFIqPqn5NV4P56BpRWTNvc9Xm9nRmYKucj
         9rVLzXC1GYwDvQyydxen6RPYDnZQaPRyI+KsNuaDhnpCvWdjmZ8Mg8PA5A+k0/siwYze
         ZkWboscEQO9CrBQcCHJYHkR636NGXyMs1KU7oPv6Zrvx1pw1UsozwbGuCQ4xtqrAx6Mh
         aqIamJ422gzs6pvhVRevOcEENww/S6+nd/nUBn+zyfXeL8L0khf/AnInJ0zFpivsT9l0
         VFMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aWzEI8RIsIrge+Ik0HeT8Rj/B4/rdob6KSKbIm3ow38=;
        b=R4ECdLE31ddmiBJUDMkjovYsxf/Qz215Np5j+g+cemZ82cZJ5v0Vh4ULx9l9Msd+B2
         FLKGQpHY9wptpEz8ZD46FZldyEkFf5Q5Gy+jmXD7A4kc+ymoV7JkUX9e7ZJXf1m/FhcJ
         eo1b5H6FZukKh/pZuYZHQ5usPdgFVq+qJFhWpXXjSCNlBKVe7T1vd4YLQ2A0cf88WzMO
         O0G7C8cJ8pgNaB1VdtyElYQ1f9DItrR/GRhtw4NJBlXfg6u3co3pqIH5RZuxwVWNJvKA
         zAWXsgBSesZK/9ehpMY1s6TyYlYWab1q+1sf5V83kGcPBApDojsX/a8dkbwMf7N/EPJY
         GyKg==
X-Gm-Message-State: AOAM530ZEbAWPpq4r9sb5OrcICnp5vtTLIaddKXNlo8gCDNs18zJ5qDW
        oE84QqMQGuPCnBgjuVzFE5vx6k62ba2QLJdyXp41xw==
X-Google-Smtp-Source: ABdhPJzlh3iKXC4o8eTmffnWRvSU3WWD8l2hitr8rJd8o/wjeDD/epeVK3W9VCxZDoDcq/CbGDUoJ5iO+7AsTyDEzgY=
X-Received: by 2002:a25:2e49:: with SMTP id b9mr36296163ybn.250.1625692046825;
 Wed, 07 Jul 2021 14:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <87sg0qa22l.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87sg0qa22l.fsf@oldenburg.str.redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 7 Jul 2021 14:07:15 -0700
Message-ID: <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 7, 2021 at 2:47 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Suren Baghdasaryan:
>
> > The API is as follows,
> >
> >           int process_reap(int pidfd, unsigned int flags);
> >
> >         DESCRIPTION
> >           The process_reap() system call is used to free the memory of =
a
> >           dying process.
> >
> >           The pidfd selects the process referred to by the PID file
> >           descriptor.
> >           (See pidofd_open(2) for further information)
> >
> >           The flags argument is reserved for future use; currently, thi=
s
> >           argument must be specified as 0.
> >
> >         RETURN VALUE
> >           On success, process_reap() returns 0. On error, -1 is returne=
d
> >           and errno is set to indicate the error.
>
> I think the manual page should mention what it means for a process to be
> =E2=80=9Cdying=E2=80=9D, and how to move a process to this state.

Thanks for the suggestion, Florian! Would replacing "dying process"
with "process which was sent a SIGKILL signal" be sufficient?

>
> Thanks,
> Florian
>
