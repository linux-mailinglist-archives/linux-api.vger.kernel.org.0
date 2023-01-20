Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66826759DB
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 17:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjATQ0X (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Jan 2023 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjATQ0V (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Jan 2023 11:26:21 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB90891F4
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 08:26:17 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so576538qta.12
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 08:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TnOBM38jwZ+FGGTAxzVN5OdFQ/WcRS5JKv2Bru4tdr8=;
        b=uDhE2Fr6pAyRvn4tBict9MP4d2ra+jv8S9DMqUwr+GSL64JdbxrXZf6Cx76qgUDgM2
         mYadOfTh1BOW0ZZL4VHqwiQUZIdM/5Rc3h9ML0BxmsXHOu3iivCixvZ7E1CPE7A2EL//
         W0g0krEFMSuAUmt+GX0lICCqV3ZC2x4Ir8pnOAbr828oPDT3skVRpBnTNwqfZ/SoK32M
         siSbDnUIolNxfFXlSz/nRoBA/2vPTHZyIPjYll/Qj0mQBzAAdzHl1HyGN90Bz9XmZL93
         tgsKjxeaFpir0zolamftaNQK7KI7NYBmV6Ln6VP5kzxUoKFQo9rfBNvEjdx6IQGQ5EXD
         YSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnOBM38jwZ+FGGTAxzVN5OdFQ/WcRS5JKv2Bru4tdr8=;
        b=pcDhDNZadQcqYF6BQaVf/GWKLolj/JCMfRtyQ7fL1ESk13AjxnRv8zR6sRNOe5kHQT
         N1lgUIHz3vW+14GZeNm+Am7kZZqiYeqye+O8wu3jGH03HcUDHuPiRozfD3Gq9kFM7gFD
         vsEuh6ZSvg13K1dIr4/Pg3m6xTsVrgBNvL2N0M7mHZf1zTDE/+vGYlxj44mZ2lNTbYqV
         dkq4bc3tgQDDvPemJFcIAholACrl631jafQebbKqa9oqHxBnpKrRl2sobw5BFC6XixoW
         PwTrMRfMpu4PffBp92s3+Kc2BZh1IPOo21BqEJfHfqAp+eUvaBmwSYI0lwrhxlMySohB
         IEog==
X-Gm-Message-State: AFqh2kpPp/v5DxyZb+HrqRbHQStQe92f5DQG25gPxuD7ivWyM7mDp/bv
        YgkDXGwyRd4zv0KotSsLdmY3gQ==
X-Google-Smtp-Source: AMrXdXsz7Cy1NvVEbD0H6s/6ZOaOGvpMhPl03HSUFX0J7J162UZn/nrSDAhQjnwgCVYcqTca3bmzqg==
X-Received: by 2002:a05:622a:4a83:b0:3a8:55c:a893 with SMTP id fw3-20020a05622a4a8300b003a8055ca893mr23602349qtb.0.1674231976245;
        Fri, 20 Jan 2023 08:26:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:bbe8])
        by smtp.gmail.com with ESMTPSA id ca24-20020a05622a1f1800b003b697038179sm1564546qtb.35.2023.01.20.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 08:26:15 -0800 (PST)
Date:   Fri, 20 Jan 2023 11:27:12 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH v6 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <Y8rA4C6qnT5InHGc@cmpxchg.org>
References: <20230117195959.29768-1-nphamcs@gmail.com>
 <20230117195959.29768-2-nphamcs@gmail.com>
 <Y8qmaqpAFko+gI3h@bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8qmaqpAFko+gI3h@bfoster>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jan 20, 2023 at 09:34:18AM -0500, Brian Foster wrote:
> On Tue, Jan 17, 2023 at 11:59:57AM -0800, Nhat Pham wrote:
> > +	int memcgid;
> > +	struct pglist_data *pgdat;
> > +	unsigned long token;
> > +
> > +	unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
> > +	eviction_memcg = mem_cgroup_from_id(memcgid);
> > +
> > +	lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> > +	lrugen = &lruvec->lrugen;
> > +
> > +	min_seq = READ_ONCE(lrugen->min_seq[file]);
> > +	return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
> 
> I think this might be more readable without the double negative.
> 
> Also it looks like this logic is pulled from lru_gen_refault(). Any
> reason the caller isn't refactored to use this helper, similar to how
> workingset_refault() is modified? It seems like a potential landmine to
> duplicate the logic here for cachestat purposes and somewhere else for
> actual workingset management.

The initial version was refactored. Yu explicitly requested it be
duplicated [1] to cut down on some boiler plate.

I have to agree with Brian on this one, though. The factored version
is better for maintenance than duplicating the core logic here. Even
if it ends up a bit more boiler plate - it's harder to screw that up,
and easier to catch at compile time, than the duplicates diverging.

[1] https://lore.kernel.org/lkml/CAOUHufZKTqoD2rFwrX9-eCknBmeWqP88rZ7X7A_5KHHbGBUP=A@mail.gmail.com/
