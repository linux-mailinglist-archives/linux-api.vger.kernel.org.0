Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFC4CFDDC
	for <lists+linux-api@lfdr.de>; Mon,  7 Mar 2022 13:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiCGMLF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Mar 2022 07:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiCGMLE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Mar 2022 07:11:04 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E8C7B553;
        Mon,  7 Mar 2022 04:10:10 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B528E210ED;
        Mon,  7 Mar 2022 12:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646655008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dkb4ct3SBLHYHDLXIznK3mCTy5dmP6jO5tiTvWElxZI=;
        b=WWwAUv6gva+yJu5ZRvAXYMvY/1LnxcAfv31J5iAQvncwwz+lDi6Fi9x+aKj4Kr7QvvdlqU
        J5KaPs9OnoVW0kSs92Ctqj49e9Rf2Qkc5L9hdXyOBuxGRps8xpbcPG6Ek7nOZE8qLuBqUA
        nZu1D0kmrrBEmDWbQ7NLAq4oUXucWG4=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2EA08A3B81;
        Mon,  7 Mar 2022 12:10:08 +0000 (UTC)
Date:   Mon, 7 Mar 2022 13:10:05 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>, dancol@google.com,
        Shakeel Butt <shakeelb@google.com>, sonnyrao@google.com,
        oleksandr@redhat.com, Hillf Danton <hdanton@sina.com>,
        lizeb@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: Regression of madvise(MADV_COLD) on shmem?
Message-ID: <YiX2HcF5o2IjfX1H@dhcp22.suse.cz>
References: <dd620dbd-6d71-7553-d1e9-95676ff12c82@nutanix.com>
 <YiKsUr1FQwmDP7V0@google.com>
 <CAOUHufZyrLrkEvFay+FddN5Ve3v_-JvNROHo9hEhsoVuCpwh0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufZyrLrkEvFay+FddN5Ve3v_-JvNROHo9hEhsoVuCpwh0Q@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat 05-03-22 02:17:37, Yu Zhao wrote:
[...]
> diff --git a/mm/swap.c b/mm/swap.c
> index bcf3ac288b56..7fd99f037ca7 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -563,7 +559,7 @@ static void lru_deactivate_file_fn(struct page
> *page, struct lruvec *lruvec)
> 
>  static void lru_deactivate_fn(struct page *page, struct lruvec *lruvec)
>  {
> -       if (PageActive(page) && !PageUnevictable(page)) {
> +       if (!PageUnevictable(page)) {
>                 int nr_pages = thp_nr_pages(page);
> 
>                 del_page_from_lru_list(page, lruvec);
> @@ -677,7 +673,7 @@ void deactivate_file_page(struct page *page)
>   */
>  void deactivate_page(struct page *page)
>  {
> -       if (PageLRU(page) && PageActive(page) && !PageUnevictable(page)) {
> +       if (PageLRU(page) && !PageUnevictable(page)) {
>                 struct pagevec *pvec;
> 
>                 local_lock(&lru_pvecs.lock);
> 
> I'll leave it to Minchan to decide whether this is worth fixing,
> together with this one:

There doesn't seem to be any dependency on the PageActive anymore. I do
remember we have relied on the PageActive to move from the active list
to the inactive. This is not the case anymore but I am wondering whether
above is really sufficient. If you are deactivating an inactive page
then I would expect you want to move that page in the LRU as well. In
other words don't you want
	if (page_active)
		add_page_to_lru_list
	else
		add_page_to_lru_list_tail
-- 
Michal Hocko
SUSE Labs
