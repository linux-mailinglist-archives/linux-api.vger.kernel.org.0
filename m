Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52A3920DDA
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 19:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfEPRY5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 13:24:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfEPRY5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 13:24:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id r4so4257652wro.10;
        Thu, 16 May 2019 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GwdAfYvM41KiSLkhlq7rAt3w1iZyUAjGI7qrOqoVW5o=;
        b=tsFelydZLhNvYDfeLAWpd9ZwFCHCG8AiKyuzgsSzXz4v0flYaDVLn//dqRSH9pssXd
         5dbeqhtnk38ShQidfbi+qNj3cWXAa0IZrsjoInLiJzcOJ8WKNS1AI7PHiiE048Ii6xZh
         IMalHDtjMxy8w+V1gZkq9SzxF36wgJAPkEx8cIMCuk7lF6NlCT1TBDxLsZ1r2ieLwTC6
         Qey5JgIKurXACewo03AC9iyGB8S9j88Oia/0rfC6MiZSwmiv6Hg8CXc/g6fNuZGzMcYy
         ITUVxvgb2V8EAfKxI9902rM1Ku1TFSOQ/XQbNIKM/NRcryk4SperNpY36Z45a+xCt4UR
         E8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GwdAfYvM41KiSLkhlq7rAt3w1iZyUAjGI7qrOqoVW5o=;
        b=D1nQzR9gfI5cbHAf1EYR11ABd8+K21IyooPzUoRQqvYKHZQkA9tyF4lBZhRcfW+QP5
         mW5oeeTKtC+HER537cBJI+HWFhZnWuyULRGYOdD1k1mPpdV1t0GycTcRfKTVTteJ8zi8
         0miZIjNYK/GggXYxEPbbKsEMMZr81rQeO8PFMOa1GPB8WCnNnOqSaIdpMQhX6bVmWEyM
         tjDZHe1PANAwIfiILkiF1x4SQXer9b0ACyrglsimLPgt4ZgQmh5j6vsWIyt/mqbp5vb4
         rqcKSaJ73nc3tViRadII/FnZZE92S2AajMPqDsGs7lNObye8zc1EmvcEAsSnH7mOZwND
         ms9A==
X-Gm-Message-State: APjAAAXmNxw3RDN1VAcPRjKrIAQgBtRE4+qK/DuuSonH03oqpsTE1x7V
        JOXMD8ax1tE6jiMWkeDFAQ==
X-Google-Smtp-Source: APXvYqxXhyZaIbtY/Sjz0UTDsBri4w8N4SWVTBL/lOnSyeL4B2It+7qNhzKrwBJjN1ueL0PAiOqHdw==
X-Received: by 2002:adf:8bc5:: with SMTP id w5mr16879957wra.226.1558027496104;
        Thu, 16 May 2019 10:24:56 -0700 (PDT)
Received: from avx2 ([46.53.251.158])
        by smtp.gmail.com with ESMTPSA id a22sm4350148wma.41.2019.05.16.10.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:24:55 -0700 (PDT)
Date:   Thu, 16 May 2019 20:24:52 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RFC 0/5] mm/ksm, proc: introduce remote madvise
Message-ID: <20190516172452.GA2106@avx2>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 16, 2019 at 11:42:29AM +0200, Oleksandr Natalenko wrote:

> * to mark all the eligible VMAs as mergeable, use:
> 
>    # echo merge > /proc/<pid>/madvise
> 
> * to unmerge all the VMAs, use:
> 
>    # echo unmerge > /proc/<pid>/madvise

Please make a real system call (or abuse prctl(2) passing target's pid).

Your example automerge daemon could just call it and not bother with /proc.
