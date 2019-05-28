Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD0CB2C1A0
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 10:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfE1Itf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 04:49:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44035 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfE1Itf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 04:49:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id n2so10551455pgp.11;
        Tue, 28 May 2019 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yyUeiuvEAPZA604X3Qsle66wGTeITptdd2/mkPm2vyI=;
        b=GUdtm2Y/xH530GIsF7hKD2bjE7d4L/YyedgUu6O7oznl9DqX84dH45WsG3vgu2VtMx
         4esY7XbmjbBgpNICqEtwGvORDOMOdigx6H6ThgY07VYfInU+DPQ+lx06LqXlKAI960cq
         LBVfzXpwEGX7+S5jPsc5h5emULZqdWjrECLRaTbhGaZsBkDU9ExuwWE5VO04YIqZXERo
         0recf4DhGEakwNR0o8N9+YSS9djGhhhmSUYV7hCm14r4yEI/gAvn0+q6YIzBefHgVbE5
         7UoC2lhWEPJ0ZG1KSZUv1tTaT4tJ6WC5p5Lnmt3MAlJ/7Uk28QlzIn5ICuyg/n7FJUQv
         OhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yyUeiuvEAPZA604X3Qsle66wGTeITptdd2/mkPm2vyI=;
        b=bwu55jVebWiFtTH+WoJ7SkL2k7xT/874Lc1TcO2bicBU2hB0nWWPOdy0qhwGkBEYmQ
         IrcJebalPi4wT5kric/A50CID0U04Q62qwJjUCQOqNVpx7W/IpTVw/BbaKXzQQMprAYd
         Fvj+CB0dlvv4uYpILkpp2gXitm+6rrIoXEdCqbXdRWv11009ZHu9CK32Qw7Mk+vdXDX/
         YtrsCgSHSuTrjEvPq5AejU7zYT1JA1ZbE30sVYa0Ga2JQQAzH+31y8N1nU7+uc/mcg9D
         7OWtAWddJdIGMTxC9Yb8Vo+nvcY2kyIFzcJbUBa9AW04DawGEDzUHsRdxuIaOwrz+TYZ
         GMRw==
X-Gm-Message-State: APjAAAUQeIGRsxByc22OzZO5oZmCBlypG1DjHZnNUOGeQhSjncG8/iXS
        qb9/iNLGyH+x3/cSJPcXfdM=
X-Google-Smtp-Source: APXvYqwv1WO8a7zoeMcXFsjLWQD88vtfSjCyEPG8TUZxQ0ivtD/z60/XLaCem2Q1YjKoTUHOIfErLg==
X-Received: by 2002:a62:4dc5:: with SMTP id a188mr90994883pfb.8.1559033374062;
        Tue, 28 May 2019 01:49:34 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id d19sm1694790pjs.22.2019.05.28.01.49.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 01:49:32 -0700 (PDT)
Date:   Tue, 28 May 2019 17:49:27 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190528084927.GB159710@google.com>
References: <20190520035254.57579-8-minchan@kernel.org>
 <20190520092801.GA6836@dhcp22.suse.cz>
 <20190521025533.GH10039@google.com>
 <20190521062628.GE32329@dhcp22.suse.cz>
 <20190527075811.GC6879@google.com>
 <20190527124411.GC1658@dhcp22.suse.cz>
 <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > if we went with the per vma fd approach then you would get this
> > > feature automatically because map_files would refer to file backed
> > > mappings while map_anon could refer only to anonymous mappings.
> >
> > The reason to add such filter option is to avoid the parsing overhead
> > so map_anon wouldn't be helpful.
> 
> Without chiming on whether the filter option is a good idea, I'd like
> to suggest that providing an efficient binary interfaces for pulling
> memory map information out of processes.  Some single-system-call
> method for retrieving a binary snapshot of a process's address space
> complete with attributes (selectable, like statx?) for each VMA would
> reduce complexity and increase performance in a variety of areas,
> e.g., Android memory map debugging commands.

I agree it's the best we can get *generally*.
Michal, any opinion?
