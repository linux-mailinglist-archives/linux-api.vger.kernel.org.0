Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D19B52CDCE
	for <lists+linux-api@lfdr.de>; Thu, 19 May 2022 10:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiESICi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 May 2022 04:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235097AbiESICO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 May 2022 04:02:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF3E5711E;
        Thu, 19 May 2022 01:02:13 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so8072720pjp.3;
        Thu, 19 May 2022 01:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=3yJKai/GSI12GvKYcBy79Bm3Kne+C3Y1/FfwBn6InA0=;
        b=lUpcKplBNBAsseV+w7F6nN0KD4nlJAUl1RQRdallDlQrwngsZEeCeHZUYTSXjyTFUc
         YsXEim9cgXxGDxa0sfNmyOl6LirJYsN+OBlKWD6WzA6LTDv3az8m9fS6YOlDMOQe9eCd
         iapq+erXJJ43Zne4GbEzqkSI+JpEma/kRtG2LwAoeUZMhHAN19au8KnGEGNAE8VPXAdh
         qzxyJ/0Z8sTZ6iHknhLW8M4Bl4kNHsWbTJKQxKXSXO/A11ypMcBBHb3Jee4b1+9nyODh
         MJImMF/s8iTiwpt0I5GW7smg8DKEcLXUH+eo9noNTC2FiTEiPvd8F254ecIeMd3+rSGX
         JDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=3yJKai/GSI12GvKYcBy79Bm3Kne+C3Y1/FfwBn6InA0=;
        b=cpeDE/QRfh5MNEF7JxHdY7HvIk/cCwkRZp4w8Yoc6Xib7IXjY46XlxQdAg29jF9nmB
         fKmGmhrkes2Z+fMvIGQFNccK6bX39CJPCO55sxkwrHKaVzSLTi278TtZNkwB7FhiGh+Z
         W4JC46pTev3/81g2CYDo+WCyQqQTjNfvJO/tbdirZD+1FvAO9+XrTvxh1VWr2XHXj/b2
         wy8QAMwl4C8eJjrrNbjU6E9heGOnEXyxLUno5PNB4nS8oiX/Wy5hoc/l1kIq5xwtSDNb
         NM5ZBvKk8QwZ3IGGQnPThhesN3QFHTXItFAFnqsjoHuRzdkm5NEvAbe8YKn2BS+KVkYE
         aZeA==
X-Gm-Message-State: AOAM532tgKLz/mIFjcouSeq32ORZ2ATQIIRA4A5WgblB61RXtbboWqP2
        eG2Y8cThkpCYPmbCF29vnX4FHg2D+5g=
X-Google-Smtp-Source: ABdhPJzsw+rFt64D5VXAScc5tgZBDAVE6tCcdwhF942qCujUmJu932Ah37KW2UkQb32431i6ejxGSA==
X-Received: by 2002:a17:90b:1a8b:b0:1dc:e565:3238 with SMTP id ng11-20020a17090b1a8b00b001dce5653238mr3900587pjb.64.1652947332557;
        Thu, 19 May 2022 01:02:12 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d4-20020a170903230400b00161955fe0d5sm3358894plh.274.2022.05.19.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 01:02:11 -0700 (PDT)
Message-ID: <6285f983.1c69fb81.b0a8b.837f@mx.google.com>
X-Google-Original-Message-ID: <20220519080210.GA1736367@cgel.zte@gmail.com>
Date:   Thu, 19 May 2022 08:02:10 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Hugh Dickins <hughd@google.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
 <YoOrdh85+AqJH8w1@dhcp22.suse.cz>
 <62845e2b.1c69fb81.cbf4a.1200@mx.google.com>
 <YoTiqm4sQCtq8C1C@dhcp22.suse.cz>
 <6285e264.1c69fb81.3f416.71a8@mx.google.com>
 <YoXzQqZ5Yluv8JMa@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoXzQqZ5Yluv8JMa@dhcp22.suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 19, 2022 at 09:35:30AM +0200, Michal Hocko wrote:
> On Thu 19-05-22 06:23:30, CGEL wrote:
> > On Wed, May 18, 2022 at 02:12:26PM +0200, Michal Hocko wrote:
> > > On Wed 18-05-22 02:47:06, CGEL wrote:
> > > > On Tue, May 17, 2022 at 04:04:38PM +0200, Michal Hocko wrote:
> > > > > [CCing Hugh and linux-api]
> > > > > 
> > > > > On Tue 17-05-22 09:27:01, cgel.zte@gmail.com wrote:
> > > > > per mm but the actual implementation currently relies on the per-vma
> > > > > flags. That means that one can explicitly disallow merging by madvise
> > > > > for a range. Is it wise to override that by a per-process knob? I mean
> > > > > there might be a very good reason why a particular memory ranges should
> > > > > never be merged but a per-process knob could easily ignore that hint
> > > > > from the application. Or am I just confuse?
> > > > For now, there is no any hints for letting KSM never merge some memory
> > > > ranges.
> > > 
> > > I am not sure I understand. Could you be more specific?
> > 
> > Not like THP, KSM doesn't have anything like VM_NOHUGEPAGE, so apps
> > cann't explicitly disallow merging by madvise. If it is really necessary for
> > a particular meory ranges of a process to be never merged, we have to submit
> > one more patch to achieve that.
> 
> What about MADV_UNMERGEABLE?

MADV_UNMERGEABLE and MADV_MERGEABLE usually appear in pairs, MADV_UNMERGEABLE cannot
appear alone. I mean MADV_UNMERGEABLE is used to unmerges whatever it merged in the
specifed range, not to disallow merging.

> -- 
> Michal Hocko
> SUSE Labs
