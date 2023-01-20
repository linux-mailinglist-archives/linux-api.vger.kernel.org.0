Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD66675D24
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 19:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjATSxc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Jan 2023 13:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjATSxY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Jan 2023 13:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5994B75B
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 10:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674240756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LLA0P2Oo0NSyC29FxsEUtLQkfAdXpwLv+bHSoAALBfc=;
        b=NsxQIerPoAxO4tTnJVEdHv8B1GNgwZxd61CI3zbQUlE+0xQ+LmliRD5x2BVd8xbMaKpJiQ
        c14HNFBpzSRhkqPNjwLEYq3j0Jua/n6HVSeBgkTyu6AmkynXHpunFen0GGR9GXWEy+MW6f
        r0mvxOjH8npBCG0jc5C4+AWT15uc+r4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-369-oSe-XdNFMtuLn_UydbFXYw-1; Fri, 20 Jan 2023 13:52:35 -0500
X-MC-Unique: oSe-XdNFMtuLn_UydbFXYw-1
Received: by mail-qv1-f72.google.com with SMTP id r1-20020ad44041000000b00536474f245aso916550qvp.16
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 10:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLA0P2Oo0NSyC29FxsEUtLQkfAdXpwLv+bHSoAALBfc=;
        b=TtTDT7+RJvdyPmBC3tiFl/nmV1fDscStLhRFLDARm/f1rLUGE6fpjhzeL8e43XMZaW
         kAFFwQupEa7q2ivnGudNiYn/AN6E/MedwvsMxuJf+jyRP3yVPu7lY2fBxnHgjpN0aHN4
         cFC5ZLyzWW4JW/Ekgnd0YBUA7tQpAid4nPmhBZylD3jeNxrf70ZzRpPm58t1OcEfIwtq
         F7RDOGLoiShzFgs4SMrCVuBVREdYmPX+xTtRomrTcVHRtqbRjqkvq0RZKddHMrMqBdXP
         TjzveXT4GlrvTznf4wfUVc0v3l4TU+yfwskTlGemPjcAk1L6kmt4ICqQ40aJ+rXIXj0z
         5zgQ==
X-Gm-Message-State: AFqh2kojI9JEWzXkmoUaPQ7sevo6zVomdjldS4RJM9JOMWZnL5zOqj/D
        2T0KkybkQIrNxs+fKZ53L2fUwRtY3uz9VIefwSjo3SI458o4To/sKYpMX91gHGJbA9hyLxk/lmm
        WU+Lk1QYNl09vDDZ1UaWc
X-Received: by 2002:a0c:e7ca:0:b0:537:4b24:7fba with SMTP id c10-20020a0ce7ca000000b005374b247fbamr2704048qvo.28.1674240754714;
        Fri, 20 Jan 2023 10:52:34 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt/+92+YuFUWrLFI6DSkbz2bjUdyl+N/U/fZqMKdgKCs/hwOTOdimPPjygjVc9xJzylT3w3qg==
X-Received: by 2002:a0c:e7ca:0:b0:537:4b24:7fba with SMTP id c10-20020a0ce7ca000000b005374b247fbamr2704035qvo.28.1674240754479;
        Fri, 20 Jan 2023 10:52:34 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id m4-20020a05620a290400b007069fde14a6sm7549789qkp.25.2023.01.20.10.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 10:52:33 -0800 (PST)
Date:   Fri, 20 Jan 2023 13:53:36 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <Y8rjMHXNH8KVKapZ@bfoster>
References: <20230117195959.29768-1-nphamcs@gmail.com>
 <20230117195959.29768-2-nphamcs@gmail.com>
 <Y8qmaqpAFko+gI3h@bfoster>
 <Y8rA4C6qnT5InHGc@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8rA4C6qnT5InHGc@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 20, 2023 at 11:27:12AM -0500, Johannes Weiner wrote:
> On Fri, Jan 20, 2023 at 09:34:18AM -0500, Brian Foster wrote:
> > On Tue, Jan 17, 2023 at 11:59:57AM -0800, Nhat Pham wrote:
> > > +	int memcgid;
> > > +	struct pglist_data *pgdat;
> > > +	unsigned long token;
> > > +
> > > +	unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
> > > +	eviction_memcg = mem_cgroup_from_id(memcgid);
> > > +
> > > +	lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> > > +	lrugen = &lruvec->lrugen;
> > > +
> > > +	min_seq = READ_ONCE(lrugen->min_seq[file]);
> > > +	return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> > 
> > I think this might be more readable without the double negative.
> > 
> > Also it looks like this logic is pulled from lru_gen_refault(). Any
> > reason the caller isn't refactored to use this helper, similar to how
> > workingset_refault() is modified? It seems like a potential landmine to
> > duplicate the logic here for cachestat purposes and somewhere else for
> > actual workingset management.
> 
> The initial version was refactored. Yu explicitly requested it be
> duplicated [1] to cut down on some boiler plate.
> 

Ah, sorry for missing the previous discussion. TBH I wasn't terribly
comfortable reviewing this one until I had made enough passes at the
second patch..

> I have to agree with Brian on this one, though. The factored version
> is better for maintenance than duplicating the core logic here. Even
> if it ends up a bit more boiler plate - it's harder to screw that up,
> and easier to catch at compile time, than the duplicates diverging.
> 

It seems more elegant to me, FWIW. Glad I'm not totally off the rails at
least. ;) But I'll defer to those who know the code better and the
author, so that's just my .02. I don't want to cause this to go around
in circles..

Brian

> [1] https://lore.kernel.org/lkml/CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com/
> 

