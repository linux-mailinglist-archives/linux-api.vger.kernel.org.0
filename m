Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 153751452D4
	for <lists+linux-api@lfdr.de>; Wed, 22 Jan 2020 11:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAVKoc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 05:44:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20398 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726094AbgAVKoc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 05:44:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579689870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKd1QMlm00TztXoKQ6PyNFCO8FaCgt8+OJzIwwiLfiU=;
        b=OxbO5SJRCy0294oCIKw0yraQc6E40CefIzUsg8ryT0r4MchtT2lSsXp3vyAohwvQ34LeS+
        tN3qSwETUzDD84Jjqdnln785/uPVqgik5LNiS0kwjeO0zGb1S12YVSm8K4VBmczvpDtH1g
        yol1KOLWwyYbj1XihKFC4VMr6dDNK00=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-cy1Z5idENtqgyezuTDF86A-1; Wed, 22 Jan 2020 05:44:28 -0500
X-MC-Unique: cy1Z5idENtqgyezuTDF86A-1
Received: by mail-wm1-f70.google.com with SMTP id m133so1187993wmf.2
        for <linux-api@vger.kernel.org>; Wed, 22 Jan 2020 02:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YKd1QMlm00TztXoKQ6PyNFCO8FaCgt8+OJzIwwiLfiU=;
        b=ky86ypvFwT9mYVsu5JSwZEG2v1YjGrsOAVzHcqp7LEaSaSd/hkFAh3CTe4ybZv6bzw
         J9eSrEqLFfe7mfDzXPFops4TQoXqHn7SK00NCdrhMHAGvmt2Ingx30IFEiMZUdMBRHnO
         Tp+oA+ljcyTnj3pbbGAp1IJw8MZM5/OJQi0bFSXDpW+q4SJRVDKvRlHSdCwZ2j1x6Gf2
         /PBMoUfyXzENhgBqTgCwQUqqsmi8xCNlYhmfRs128ydlPMJwCdjhkePxMEA4Dal3nbld
         JJ6Zdjubpgm59L+5riGMB5o165aWfY7XDHXcnhmJjtFcXL4MUFyj0/Pq/CBAPI8Zx/wJ
         r3uw==
X-Gm-Message-State: APjAAAX0To+oTHmMzqziWsxaBWpZeUaDOxw2IdTNnGnzlAcKx6IyEYJI
        RQyeNym1Ve8VIRoiLvHuTZnf0Oar8ak9miNqR+vxqoalSsFfJU+ETwNjGl2UU4Uf8ZutYTp7P1k
        rxj+xbjgRT8I0slzjR6QL
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr2243091wmc.64.1579689867582;
        Wed, 22 Jan 2020 02:44:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqzf4N7NDysvCU8k0EDfB9CCu9AGjs9RwppVG9KvmCJKfdHbDr0hbTUL7DfxuEinfHmAaQFORQ==
X-Received: by 2002:a1c:66d5:: with SMTP id a204mr2243066wmc.64.1579689867379;
        Wed, 22 Jan 2020 02:44:27 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x10sm55168995wrv.60.2020.01.22.02.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 02:44:25 -0800 (PST)
Date:   Wed, 22 Jan 2020 11:44:24 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>, ktkhai@virtuozzo.com,
        christian.brauner@ubuntu.com, sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200122104424.7gvrfivymjvdous4@butterfly.localdomain>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200121181113.GE140922@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121181113.GE140922@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello.

On Tue, Jan 21, 2020 at 10:11:13AM -0800, Minchan Kim wrote:
> > > I also think people don't want to give an KSM hint to non-mergeable area.
> > 
> > And how the manager knows which data is mergable?
> 
> Oleksandr, could you say your thought why you need address range based
> API?

It seems I've overlooked an important piece of this submission: one
cannot apply the hint to all the anonymous mapping regardless of address
range. For KSM I'd rather either have a possibility to hint all the
anonymous mappings, or, as it was suggested previously, be able to iterate
over existing mappings using some (fd-based?) API.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Senior Software Maintenance Engineer

