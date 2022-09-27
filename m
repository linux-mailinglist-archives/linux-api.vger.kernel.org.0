Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B906E5EC98E
	for <lists+linux-api@lfdr.de>; Tue, 27 Sep 2022 18:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiI0QdU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Sep 2022 12:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiI0QdS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Sep 2022 12:33:18 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F81616CA
        for <linux-api@vger.kernel.org>; Tue, 27 Sep 2022 09:33:17 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-130af056397so13968748fac.2
        for <linux-api@vger.kernel.org>; Tue, 27 Sep 2022 09:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pVGyzlZKdVDER9c1CMr32QZSC2mWMTtkTxmn7AiH778=;
        b=ejLSXbmSx7tCsR67CdpHh86gWav+BH7uaVCZoXPwMgX3anPViTffC+5LNvh/Jwn7/y
         w1MpgI73uOevWtbMXyLeFsluAlxHeOIqrSAoGpa5cfJZLWXDOgGjxZhigwOGYHS//QvE
         cia5XAH6+nqB+JZd+unsezSKTBxtJwLWyy7G4Q/AED9xqAR9sCXgjdYrBTI0iAXBxWsp
         JIygHt3xZb3FvjAXkKlowc3eSBHhcbFX+5YlMd47NwMCYVWCuXkzxJ9hxBlVb3fW0cFk
         meSn2SD1QUsR8IZbBDk/zmkY60G+QkEw4gL50UV8s7XsFEZ0qiVy+Pm7xSRtCg22dIZ2
         Qb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pVGyzlZKdVDER9c1CMr32QZSC2mWMTtkTxmn7AiH778=;
        b=pDAuQnwv0T5kQDFfejngy4GiI4gvHg6pDVFq9EgdhYrvL0WnAO34GSEos1xOwzSh0p
         Xa6OxXQHE9sk4qRce+EfbGPdU3eqPEMjHy7iikNd3tRB7PpJhlbtRAvvsGTUbrNLWDl/
         ju4SZp1cVe/ZBZbC6VxEjIlYG3MxEqdxTdzZrXN/SmJLCqjfKtgwV308sP+vln6fXnzC
         Y6dSCclycljg3EHqYh/nkY7Qc4h189vi8U3Gp8GVixQ4Ax7GxYjFWLYxXfCYYy2rxMOi
         mVjT1qehm8cTFUniqtZEyEAW2qZicFEIKfj6NgZqohpQRqfw44Ag17FTnM/j8bFnYIMd
         gwmw==
X-Gm-Message-State: ACrzQf0HvnJnn4ZIHhNPKaeTCNxYXnwhyoxmlYhvRElOGbmIvBVu4Z3U
        BAfyPqw5bbnLJHeSnpS3dYnzeJIRcet5n2+FGb0Vdw==
X-Google-Smtp-Source: AMsMyM55ZtqQRnrtRyQkJTs2sESgnadkXy2HeD9UHOCBNEP/xmgvxE7Ki4bMswkl2z69DeOU7YstUiaA2afZQYciiM0=
X-Received: by 2002:a05:6870:c1d4:b0:127:9423:22b8 with SMTP id
 i20-20020a056870c1d400b00127942322b8mr2690166oad.123.1664296396022; Tue, 27
 Sep 2022 09:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220922224046.1143204-1-zokeefe@google.com> <20220922224046.1143204-6-zokeefe@google.com>
 <B6259986-56F7-4393-88F7-69DE839C53F2@nvidia.com>
In-Reply-To: <B6259986-56F7-4393-88F7-69DE839C53F2@nvidia.com>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Tue, 27 Sep 2022 09:32:40 -0700
Message-ID: <CAAa6QmQHX2trqNpV9qVq6o+oYQB18_TgTbLMM=+kw+k-aif_aQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v4 05/10] selftests/vm: dedup THP helpers
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-api@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Kennelly <ckennelly@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

> LGTM. Thanks. Reviewed-by: Zi Yan <ziy@nvidia.com>
>
> --
> Best Regards,
> Yan, Zi

Thanks for taking the time to review, Zi!

Best,
Zach
