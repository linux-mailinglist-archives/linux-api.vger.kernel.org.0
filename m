Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6F511808EC
	for <lists+linux-api@lfdr.de>; Tue, 10 Mar 2020 21:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbgCJUQd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Mar 2020 16:16:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33814 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCJUQc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Mar 2020 16:16:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id 23so5224628pfj.1
        for <linux-api@vger.kernel.org>; Tue, 10 Mar 2020 13:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DUOjVP5Gbs/kqvClABR44FE8+xg+AgbM19bKNtAY6RM=;
        b=J4M0uyN8yr+WE91/EnStnaXtqW7/nhowSFEP7427vQyPhmyVseK/RtuSzWChg/C9Hr
         zZ+zMYnkWIePFvXZqr08Bgtu6LZxyciu3wJk6FDiKEN2gAr2hr9x1d1z8YndRb7xny59
         LIF8JAG0apaOV2Wrk6HcAMaxdWObISAFLKEGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DUOjVP5Gbs/kqvClABR44FE8+xg+AgbM19bKNtAY6RM=;
        b=ETylwflEVHt84sZExgkI6eZN5zXHm5iJsYixxQsI74NwC7kDva2W230i6lwJzYz6yU
         9jv07+XuNJ/mRKWfALVFL7N4LuWrzEPPMNMWw2fYrYAYq8Se3aJDimiEVK8KkBdtyTUP
         ZWt3Kg6ensJkqhgC7CkRge2Xd44XeiWFsGIii27/MsO7jeu7dAd+qgsqoYL3rG6u/622
         YHems3inax0hUfXzZ1lsb8QpChV2zSqciyaGHBTmXgAjmMImh59lvahTPzGLnkoshx9Z
         BFkTSYEg7NSzJ6yrNhncGBxYFwoq5TkaZpZQJ0wjC1VDZoc05DFBEqyD3Dg/ZJ5OtdYi
         HMRg==
X-Gm-Message-State: ANhLgQ3IyIaW1HBXQybRAxhMoeGgBJaY7K+DDz31+3sYTTNItBdRqIqe
        qVIgoMPFfG7tTGSjJvlMMjABgQ==
X-Google-Smtp-Source: ADFU+vsvmkmyViYLeWPBKmK8uPBvLdmLN608raLFS0mCOwqgEfnZb/AeMfnBRwxnwZ3Ngq2HL/ZZcg==
X-Received: by 2002:a63:2882:: with SMTP id o124mr6655825pgo.390.1583871391628;
        Tue, 10 Mar 2020 13:16:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm45162722pfq.160.2020.03.10.13.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 13:16:30 -0700 (PDT)
Date:   Tue, 10 Mar 2020 13:16:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yuyang Du <duyuyang@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Kellner <christian@kellner.me>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] exec: Move cleanup of posix timers on exec out of
 de_thread
Message-ID: <202003101313.CF8CBDC582@keescook>
References: <87r1y8dqqz.fsf@x220.int.ebiederm.org>
 <AM6PR03MB517053AED7DC89F7C0704B7DE4E50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <AM6PR03MB51703B44170EAB4626C9B2CAE4E20@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <87tv32cxmf.fsf_-_@x220.int.ebiederm.org>
 <87v9ne5y4y.fsf_-_@x220.int.ebiederm.org>
 <87eeu25y14.fsf_-_@x220.int.ebiederm.org>
 <20200309195909.h2lv5uawce5wgryx@wittgenstein>
 <877dztz415.fsf@x220.int.ebiederm.org>
 <20200309201729.yk5sd26v4bz4gtou@wittgenstein>
 <87k13txnig.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k13txnig.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 09, 2020 at 03:48:55PM -0500, Eric W. Biederman wrote:
> And I completely agree that we should at least rename tsk to me.
> Just for clarity.

I think it wouldn't hurt to add comments to spell it out explicitly
in each of the tsk->me functions, something like:

/*
 * The "me" task_struct argument here must only ever refer to "current",
 * but it gets passed in to avoid re-calculating "current" in each helper.
 */

I've found that the exec code in its entirety would be better off with
more comments. :) Usually that's the bulk of what I find myself adding
when I make changes in this area. ;)

-Kees

-- 
Kees Cook
