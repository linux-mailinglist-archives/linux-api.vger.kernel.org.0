Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17375FB91B
	for <lists+linux-api@lfdr.de>; Tue, 11 Oct 2022 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiJKRWj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Oct 2022 13:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiJKRWi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Oct 2022 13:22:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58095AA20
        for <linux-api@vger.kernel.org>; Tue, 11 Oct 2022 10:22:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d26so25824467eje.10
        for <linux-api@vger.kernel.org>; Tue, 11 Oct 2022 10:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tD9jR7qHoo8YjCPFAxtMgRghcsI0I3euLcmHX/AlDvk=;
        b=EG3pijXaCZAx0z7+DzNm/ASYYg3E5j3bCUvD9D1vXPg0vGbv7rSmWRFf+49wNrOjPC
         XgB9u2o/1y2tnzLsdca6ebyRx8nNHH+TcgbL4bosKJZBi3Q6JBHOnWZhuWd3TMiGpK0W
         qUqplH1WfiIV27fsfHUt9ko6yhHMZp32J6NLnAYkBDd4AQSkHidIiGKvs5DCXkvBO5hF
         subwyAFDVEt33ulB4j6S8wDFl/z7aH4H73nqR0aPqy/DSs/DCwi98lV5QH3cvDLQMMft
         zGXv1Z3V2aDk5tyMCO22+B1TZ7WjzVHijfIx/Ek4rbzQXt0uvboaMorpjZHSA/OP/KNt
         8VNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tD9jR7qHoo8YjCPFAxtMgRghcsI0I3euLcmHX/AlDvk=;
        b=CxhmFPMVNQqpN0Kg8M0hWisQ9N1Sh03IN0JcWy5+3VKu7MYq5vXUFSa7TXKjv7QHjo
         vXYquDMRkXtatZSKljzesm51J1JMMYJiqUFkcWssvV/S2i4mE66H/1Xms1dpdsxttWII
         A8uIjq+Vu8Sryc+KJnZcGMfV8brGecRwyQgGfC7PDlnpmPVLmhcdbVJuh820vDl+IJlG
         W9DkS8UUESPlxZvgyGrMBpZxbLrcREm0M6RvNtZhpV5nNYhP28qJ/awQfqdSqOWOtw1y
         2b/Uh8wmLqHhTeD5Gn2aeoWGxAIhC0oJAXzJE432pHHk5oD2WzBcijT8AWtAM3E4hWqV
         YstA==
X-Gm-Message-State: ACrzQf3Qan3MIBQ7ST3iUrdLP+wSICaMLhW2omag0WJTre/Q6er5mweH
        HvON8MAV9Qiihpg1kopEWAFcPDT2sKHIC5Jl0DZJAw==
X-Google-Smtp-Source: AMsMyM5ZC8bySD0ur+e6jyv+eDlRBwAazeHKoD2ZcGUoZbIE0AMED9AS38/kZXKX5FECDsvvfbQ8I6W0UQAoyEgijY4=
X-Received: by 2002:a17:906:4fca:b0:78d:b042:eeca with SMTP id
 i10-20020a1709064fca00b0078db042eecamr9869193ejw.685.1665508955072; Tue, 11
 Oct 2022 10:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <CAPTztWYTGOb8ZQzfgThqJn+fyi4ZB8=JQQZi5_rUoDhdftKtvg@mail.gmail.com> <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz>
In-Reply-To: <Y0WE/lEiNvl2ljo1@dhcp22.suse.cz>
From:   Frank van der Linden <fvdl@google.com>
Date:   Tue, 11 Oct 2022 10:22:23 -0700
Message-ID: <CAPTztWZZOxtzdEm=wbOiL_VDPJuCaW0XVCvsdRpCHE+ph+5eZQ@mail.gmail.com>
Subject: Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>, corbet@lwn.net,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 11, 2022 at 8:00 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 10-10-22 09:22:13, Frank van der Linden wrote:
> > For consistency with process_madvise(), I would suggest calling it
> > process_set_mempolicy.
>
> This operation has per-thread rather than per-process semantic so I do
> not think your proposed naming is better.

True. I suppose you could argue that it should have been
pidfd_madvise() then for consistency, but that ship has sailed.

>
> > Other than that, this makes sense. To complete
> > the set, perhaps a process_mbind() should be added as well. What do
> > you think?
>
> Is there any real usecase for this interface? How is the caller supposed
> to make per-range decisions without a very involved coordination with
> the target process?

The use case for a potential pidfd_mbind() is basically a combination
of what is described for in the process_madvise proposal (
https://lore.kernel.org/lkml/20200901000633.1920247-1-minchan@kernel.org/
), and what this proposal describes: system management software acting
as an orchestrator that has a better overview of the system as a whole
(NUMA nodes, memory tiering), and has knowledge of the layout of the
processes involved.

pidfd_mbind()  makes sense to me, since the notion of an external
agent with knowledge of the VM layout is already there with
process_madvise(). And since set_mempolicy and mbind are closely
related, it would seem logical to add an mbind variant as well as
pidfd_set_mempolicy().

Having said that, I'm fine with leaving that discussion for another time.

- Frank
