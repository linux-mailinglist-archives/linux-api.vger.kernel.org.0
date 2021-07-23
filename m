Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7E3D3B5B
	for <lists+linux-api@lfdr.de>; Fri, 23 Jul 2021 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbhGWNFq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 23 Jul 2021 09:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhGWNFp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Jul 2021 09:05:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE98C061757
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 06:46:19 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id f12so1796209ljn.1
        for <linux-api@vger.kernel.org>; Fri, 23 Jul 2021 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+ag2d72KvvFEXZNBsdQcAfMeju6Pa8JiIFVIvwyZAs=;
        b=Bel0NWzfFa7+d0KBmjVVM5nyRPf5LEz7p5f/UNtfAB3KKC96xHbvTXWvvBbDrM72ZT
         SXzM2conoYeEZZEkJzsgAfViHZODQnnziIxW6NqqsuypTghZgf8poGb2JK44l6zAAcaC
         i9Zy6ftMma9CWf8ne5JIemBQgOSSMEEMmUCloaNBkmVSkf/4xN9A9PdqMccjr86sO/L0
         SlZ2zOvit+JbzDXBXK2HNeAo9yEGfaIhs58ErsHRUutYP/eJa7m9LcUCFmPE1kKKpqWX
         WV/fA8ZMK01uTIlDsfdmpgAb14HExE356njQnykVutaFhedklFS4hrmq3dh94Ebo0o7a
         JtWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+ag2d72KvvFEXZNBsdQcAfMeju6Pa8JiIFVIvwyZAs=;
        b=QpPl13bPCTpIIbG7WnAfNrHi6aoFbeWpdqj/i8/xwQm9jIG2lPjO5kFjjGdCoEJ/U6
         nmr9HvsrItMYNUG/KonadubHPGWxpNWcaReoCPMSR9sH2COVzXSJv858aLbxLxwHFP0r
         /rU8KDF3Pk92VlVg0W51Xf9haLdNNlHxNRa3vcXhnJrUinkkMRrPfErv6QvSD/G0Uv2Q
         KUh31eVqMQRdE3b6EIJ8+8LNas0Vlq4alfIP/+lvgjZLe2W17Svh9ikMi0j4jNfFdAzW
         +axgD1HoYydJQF7XQXtw1UDQ3a1KJKfTDDJxQ/n8G7maE5ie5pmxIgmOSIP9X6fJQ5hT
         ooNg==
X-Gm-Message-State: AOAM531AVYiPRPEG+VoFAcxm5CMndFxy6j7pNUfiOqrILGeU8QFWaTyR
        YfBHRGhCi2+ejJwe7GKnHNfoaNLqq9nE/tQPNeRBIg==
X-Google-Smtp-Source: ABdhPJxHBOisaZMsrpVGL5IjrNztOtO9ALzW8qKpkWXbWzvMb52gUbcej6/EFccqagBqkkFhvSoB5KjNacZFYxqbkBQ=
X-Received: by 2002:a2e:9ec1:: with SMTP id h1mr3464593ljk.0.1627047977179;
 Fri, 23 Jul 2021 06:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210723011436.60960-1-surenb@google.com> <CALvZod7ehaHoWRD-Pzvet5c1LQ6DYDHjs=xbJWZYEdMsgTpRgA@mail.gmail.com>
 <CAJuCfpFZeQez77CB7odfaSpi3JcLQ_Nz0WvDTsra1VPoA-j7sg@mail.gmail.com>
 <YPpfo2z8feq0vTlE@dhcp22.suse.cz> <CAJuCfpGSZwVgZ=FxhCV-uC_mzC7O-v-3k3tm-F6kOB7WM9t9tw@mail.gmail.com>
 <YPqDnqULylkkzQG5@dhcp22.suse.cz>
In-Reply-To: <YPqDnqULylkkzQG5@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 23 Jul 2021 06:46:06 -0700
Message-ID: <CALvZod4=9aEd9tUdku293uhVQ4mqsfYckCOKzqxXVTDYsmaVtQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: introduce process_mrelease system call
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 23, 2021 at 1:53 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
> > However
> > retrying means issuing another syscall, so additional overhead...
> > I guess such "best effort" approach would be unusual for a syscall, so
> > maybe we can keep it as it is now and if such "do not block" mode is needed
> > we can use flags to implement it later?
>
> Yeah, an explicit opt-in via flags would be an option if that turns out
> to be really necessary.
>

I am fine with keeping it as it is but we do need the non-blocking
option (via flags) to enable userspace to act more aggressively.
