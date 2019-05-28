Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713AF2C159
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbfE1Ib0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 04:31:26 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:40688 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfE1IbZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 04:31:25 -0400
Received: by mail-vs1-f51.google.com with SMTP id c24so12252544vsp.7
        for <linux-api@vger.kernel.org>; Tue, 28 May 2019 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDpCbodGGyTl/G0ilhTF0HY0iZvF6dtHic3QCj90ipM=;
        b=oZXsDC139BFCteWhHBnBHACBOyQMeYRAOrZf/VJ9wS/tQrz+S5esMvP0w8pm449GB0
         cmPfZW9ULRdT8n87/iMLMqbXXoNT2419ayfmemKqxIJh/KqXliDTTIoDy/JJkTCzYryx
         iIlEjh1oNEoJ4CStLL3ikYedgGLSj31O/YU1e5WlFayKAu5dl4Cfe9sAOMTSo6ok56dv
         SscPem+FZ6pZKojuqiPTl9gCzY8bvmH3jPqX75TAYNEMn8ednqktRfMImHunEbKtoRUv
         Lf1i1JxgNOSbcFvnNzWMo0/z3X2u7Op2IXl1Rdo2AYwyzRhLvuUtMZjXo6ABqCq7Hxjt
         u1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDpCbodGGyTl/G0ilhTF0HY0iZvF6dtHic3QCj90ipM=;
        b=bRrxRVQwhSYXTEvArsbfBgrLde8Jrj0TmprZDdsVEMlvRELqnDQvrGXBgLwe1ba5Xe
         +q3gXHQaFtkBd9lcoEEtWYeQW7Km5gTky6xdJcF7v7XDvkbhHuEY9IgALUuo/lVJh2WC
         NMMkjTzMNya731OOjzrK1t/pI+lkrYukPqGw+ml0r8yIjYNiSuvWpLZgRAXR2EjLfRri
         wQ6ElVzqeByjozph5SBopilIe3VeJNLykiyihtukDnccSH9zOevXfEO/P7hkpcpkt7te
         dB2sXdnqF7wStMl4agz0BZDvOf0RkPNZrrZPC/cd/71raDEM+MYTTs+0IdOrFTmtgliW
         MfZg==
X-Gm-Message-State: APjAAAU7SWu5Yd4IaqW2ZJmrqs2VasYj4x72DrHHsuqNXJF299+/ftkS
        T0/f5NLUa6MwIqHm12PnK7FKbTyaI6rqMUqanIt1Og==
X-Google-Smtp-Source: APXvYqzE8QewMLUeXU4DZglD7H5qffJkLV6mdCsxLIk1a1dGSRHlmjrRoO/5otC9dc45/lQq+x8myk+C/2zbJELkiOo=
X-Received: by 2002:a67:e1d3:: with SMTP id p19mr60303726vsl.183.1559032284339;
 Tue, 28 May 2019 01:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190520035254.57579-1-minchan@kernel.org> <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz> <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz> <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz> <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz> <20190528081351.GA159710@google.com>
In-Reply-To: <20190528081351.GA159710@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 28 May 2019 01:31:13 -0700
Message-ID: <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and MADV_FILE_FILTER
To:     Minchan Kim <minchan@kernel.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> if we went with the per vma fd approach then you would get this
> > feature automatically because map_files would refer to file backed
> > mappings while map_anon could refer only to anonymous mappings.
>
> The reason to add such filter option is to avoid the parsing overhead
> so map_anon wouldn't be helpful.

Without chiming on whether the filter option is a good idea, I'd like
to suggest that providing an efficient binary interfaces for pulling
memory map information out of processes.  Some single-system-call
method for retrieving a binary snapshot of a process's address space
complete with attributes (selectable, like statx?) for each VMA would
reduce complexity and increase performance in a variety of areas,
e.g., Android memory map debugging commands.
