Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C890614DA51
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 13:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA3MC6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 07:02:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36406 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgA3MC5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jan 2020 07:02:57 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so3747558wru.3;
        Thu, 30 Jan 2020 04:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PXJWX2zI/JSBgEXdeTT2YWS+/RJ56LXcmiP58AIC6fw=;
        b=kHhq0owAh1i6M1a7r8QO/YhWo9lNxZs6KlWiOctRSOt0jCizXdcHlB5ko+ZI3eVGlO
         YHzygB/7bQzMqF2YGQTWNmBbB3MNLhQsRiYgUFvU19xnHgTd0UFUzfj009td1o6IIrl8
         MRyKp2OHuaagNEss7NibJMrLCPPrR/AMBwWA58LUJAvI1S+F4WVdeEwjvPU15trNmJ9m
         ngQXKeJJKbls43I8uMeWfJmXYAtkUu2o9tZYFibqjGLVKQe4T+FavrUE6OJrU38gE51O
         ru7HhxD5hujBIRXy1FcIk/dIlNo0iCfCsctYrz06S4+Kwe2rUiIY8p4tTn+ucQYoGRf7
         RYjA==
X-Gm-Message-State: APjAAAUHAYyTFHdZj5iigC0aXN0zJOktjD8IHVK/yt7J0ywt/osnBDC6
        KpaZbK8OnBEcqpLQGBspXDc=
X-Google-Smtp-Source: APXvYqyaLvD8q8tKyIb+hw3kUODevmo5lXICKwIVfKW2L2p5bMVVBOae6j8IBnWxNsLXb6bRV5zLLA==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr5269504wro.263.1580385775342;
        Thu, 30 Jan 2020 04:02:55 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o4sm6892192wrw.97.2020.01.30.04.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 04:02:54 -0800 (PST)
Date:   Thu, 30 Jan 2020 13:02:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] move_pages.2: Returning positive value is a new error
 case
Message-ID: <20200130120253.GU24244@dhcp22.suse.cz>
References: <1580334531-80354-1-git-send-email-yang.shi@linux.alibaba.com>
 <f276d8ec-b1be-4f8e-792b-5c3ca2de4714@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f276d8ec-b1be-4f8e-792b-5c3ca2de4714@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 30-01-20 10:06:28, Vlastimil Babka wrote:
> On 1/29/20 10:48 PM, Yang Shi wrote:
> > Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
> > the semantic of move_pages() has changed to return the number of
> > non-migrated pages if they were result of a non-fatal reasons (usually a
> > busy page).  This was an unintentional change that hasn't been noticed
> > except for LTP tests which checked for the documented behavior.
> > 
> > There are two ways to go around this change.  We can even get back to the
> > original behavior and return -EAGAIN whenever migrate_pages is not able
> 
> The manpage says EBUSY, not EAGAIN? And should its description be
> updated too?

The idea was that we _could_ return EAGAIN from the syscall if
migrate_pages > 0.

> I.e. that it's no longer returned since 4.17?

I am pretty sure this will require a deeper consideration. Do we return
EIO/EINVAL?
-- 
Michal Hocko
SUSE Labs
