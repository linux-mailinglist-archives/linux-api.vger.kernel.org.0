Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C73CE989
	for <lists+linux-api@lfdr.de>; Mon, 19 Jul 2021 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353256AbhGSQ5l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Jul 2021 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358905AbhGSQx3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Jul 2021 12:53:29 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81A1C0F26EC
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 10:11:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d17so7322520ljq.12
        for <linux-api@vger.kernel.org>; Mon, 19 Jul 2021 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+vqFcAPpr2Wrm3IQBRWJ29wt2kc6RE+Zc3iAnlFe6GY=;
        b=DREFa+Crra3/Gwt/ozWS6XyyFKY4Mg7dPcld3cizJiTFXWiznp9HUE67QvDO9oZbMl
         3B000kz0sS3krAYD5a9gSu4NLZy1dE4yjQ9TVgBrKCK528Roj8zK08CGtsxThRGSyXDy
         ffWrnC9O7291POYBsVEi4zTCMxsxY7N/ykOM/tzi3rOF108KqHG+a3+2JefEhIN/oX0f
         VyMRoQNFp8urHC5L9xqQac7l8DS+rfqzzY7gd9u2EOqO//9C9pgpq/ZMCAFw4jQUsB6A
         v19hBqOGOdThZ0zo/07dXAHgVKO8uuU8kzOaDdOVo8Li2Tzapur/tu/weHW3xGPsT6zs
         GwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+vqFcAPpr2Wrm3IQBRWJ29wt2kc6RE+Zc3iAnlFe6GY=;
        b=ehOeT8YH1GrZuz/wsKPRkrPgeS+4v6SfasSeltZ+GCc0Q87RLBGa+BrnrvfYkWk70x
         nXA6fQo82L/yl6lZ6ujKsQNmBHBUJimyklQLuPgUh+ayWfiJNezXQlQFsyz3CoCxcAZe
         n47Od7A/lDu+7IDVu6TjfwdychKpGYRuTgP195j8ZNW25imJMhFc1viC/I2V0HDINzGe
         aGlvIZfuVKXXWFspl9EMaqnU9+1ND5ZbCVKhWWajNfYFlvurXGcBRNPKVkqzZC4P1S+o
         onZsUvWYgN1FNUsHva7LV4cAnZA6SUmpI7wYTEE9f5tb9srJ4EmtJJLDXvCzCF+aevrx
         pa6w==
X-Gm-Message-State: AOAM530nww/qulTrURy2Ex9KMXGl8SSI0vn4OXTw/GjzPE+y/nKMlaS0
        FULyJshRgViPniqOmtIvPNHSQmg3yNcE71MTAfNA9A==
X-Google-Smtp-Source: ABdhPJyo55MqgRQDKulqoMn04KoWQCUp51qWy4Z5KYNeT0BBLUr4vsWWfK5wvi9jXem9ykTLN5UMvoyZTpEdSMcXwUM=
X-Received: by 2002:a2e:934f:: with SMTP id m15mr22566736ljh.208.1626715811254;
 Mon, 19 Jul 2021 10:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210716184719.269033-5-posk@google.com> <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
In-Reply-To: <2c971806-b8f6-50b9-491f-e1ede4a33579@uwaterloo.ca>
From:   Peter Oskolkov <posk@google.com>
Date:   Mon, 19 Jul 2021 10:29:59 -0700
Message-ID: <CAPNVh5cmhFEWr4bmODkDDFhV=mHLcO0DZJ432GEL=OitzPP80g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4 v0.3] sched/umcg: RFC: implement UMCG syscalls
To:     Thierry Delisle <tdelisle@uwaterloo.ca>
Cc:     posk@posk.io, avagin@google.com, bsegall@google.com,
        jannh@google.com, jnewsome@torproject.org, joel@joelfernandes.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        tglx@linutronix.de, Peter Buhr <pabuhr@uwaterloo.ca>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 19, 2021 at 9:07 AM Thierry Delisle <tdelisle@uwaterloo.ca> wrote:
>
>  > /**
>  >  * @idle_servers_ptr: a single-linked list pointing to the list
>  >  *                    of idle servers. Can be NULL.
>  >  *
>  >  * Readable/writable by both the kernel and the userspace: the
>  >  * userspace adds items to the list, the kernel removes them.
>  >  *
>  >  * This is a single-linked list (stack): head->next->next->next->NULL.
>  >  * "next" nodes are idle_servers_ptr fields in struct umcg_task.
>  >  *
>  >  * Example:
>  >  *
>  >  *  a running worker             idle server 1        idle server 2
>  >  *
>  >  * struct umct_task:             struct umcg_task:    struct umcg_task:
>  >  *    state                         state state
>  >  *    api_version                   api_version api_version
>  >  *    ...                           ...                  ...
>  >  *    idle_servers_ptr --> head --> idle_servers_ptr -->
> idle_servers_ptr --> NULL
>  >  *    ...                           ...                  ...
>  >  *
>  >  *
>  >  * Due to the way struct umcg_task is aligned, idle_servers_ptr
>  >  * is aligned at 8 byte boundary, and so has its first byte as zero
>  >  * when it holds a valid pointer.
>  >  *
>  >  * When pulling idle servers from the list, the kernel marks nodes as
>  >  * "deleted" by ORing the node value (the pointer) with 1UL atomically.
>  >  * If a node is "deleted" (i.e. its value AND 1UL is not zero),
>  >  * the kernel proceeds to the next node.
>  >  *
>  >  * The kernel checks at most [nr_cpu_ids * 2] first nodes in the list.
>  >  *
>  >  * It is NOT considered an error if the kernel cannot find an idle
>  >  * server.
>  >  *
>  >  * The userspace is responsible for cleanup/gc (i.e. for actually
>  >  * removing nodes marked as "deleted" from the list).
>  >  */
>  > uint64_t    idle_servers_ptr;    /* r/w */
>
> I don't understand the reason for using this ad-hoc scheme, over using a
> simple
> eventfd to do the job. As I understand it, the goal here is to let
> servers that
> cannot find workers to run, block instead of spinning. Isn't that
> exactly what
> the eventfd interface is for?

Latency/efficiency: on worker wakeup an idle server can be picked from
the list and context-switched into synchronously, on the same CPU.
Using FDs and select/poll/epoll will add extra layers of abstractions;
synchronous context-switches (not yet fully implemented in UMCG) will
most likely be impossible. This patchset seems much more efficient and
lightweight than whatever can be built on top of FDs.

>
> Have you considered an idle_fd field, the kernel writes 1 to the fd when a
> worker is appended to the idle_workers_ptr? Servers that don't find work can
> read the fd or alternatively use select/poll/epoll. Multiple workers are
> expected to share fds, either a single global fd, one fd per server, or any
> other combination the scheduler may fancy.
>
