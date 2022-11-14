Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FB0628AC2
	for <lists+linux-api@lfdr.de>; Mon, 14 Nov 2022 21:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiKNUtQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Nov 2022 15:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKNUtP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Nov 2022 15:49:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE34914D2B
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 12:49:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id j12so11205764plj.5
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 12:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkgjefB1+6KbyMu0uuZ086tg7a8inwZvw55s87p+Sl8=;
        b=R2VcHAQWKWoSy4Ex1PFK4F3oamdO5rj1n4O638YozO3My7kwm1gCGnmnzN36/1/33q
         M748CRiXx4GbKbhsi2m9V54akbITPAKUw8XuAx/JCyOtHTOels+9fKThsDYLCslHkNwa
         +ehxiQOJ8RAnW9A1nb3Bk+FBnAfTcEmje3wFwqXwuflaSsZegBhb0+ChHR9qo+mweJO0
         TTwJDB6JySiBnton9O55nP66yKkloLmeGdStBtpmHt5kXS3ueRP/K3gVxDTt/g6y7nuh
         kMT/csMSQObsM5p7RXAVAUet3euhxmUZslozcZVpOJPoCHCkmpa5y3v+jFZswfXHOq21
         oVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkgjefB1+6KbyMu0uuZ086tg7a8inwZvw55s87p+Sl8=;
        b=grOaHo1yY/+pYMtUpShOjiDIgWRezGUZCPwlXGlWGhvwFr5o8w82POfKiqfqhb5FMO
         ZU6eOjVxLk+6AZCpiKSeyM3cU0lkPBSDyokWcKf/Oik4E26xrGAlnIi76yjhz90h7Xf2
         j3c2c+ZbvFg9ynBeCKhQlwhLffj8LJkVzChaX/wDgb/MPhetlKkeBanGcMf8meF7yIZ0
         CDLFX5QD00V+GHYmfBTYMhtmPIzN9aVsSUssuqWurKlNEVCOJzt2DPrF91sxar4h3CvE
         zILF6xwhb3MQhPslYAF0lDsGBEedEd0MoE4SVtrn2jaFYoedcZbrr83aGk5kR/9yZ2sA
         xnug==
X-Gm-Message-State: ANoB5pkj48H6DOFocrO5gPkVpsvBM96DxsOz1OzBvhxFeplS8bPndiyy
        oyC5ycXlYWj+K2u0i1R37/Dx0w==
X-Google-Smtp-Source: AA0mqf4QfkDuhsj6MXKqI+aIdHahZZ03Y/CtArwCpMRQUe+J2W/5u2HBqoHFVITNxUGEwp/FQbRjow==
X-Received: by 2002:a17:90a:617:b0:213:cb87:8cd4 with SMTP id j23-20020a17090a061700b00213cb878cd4mr15433263pjj.78.1668458954145;
        Mon, 14 Nov 2022 12:49:14 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i24-20020aa796f8000000b00562784609fbsm7129596pfq.209.2022.11.14.12.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 12:49:13 -0800 (PST)
Date:   Mon, 14 Nov 2022 20:49:09 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@aculab.com,
        carlos@redhat.com, Peter Oskolkov <posk@posk.io>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Chris Kennelly <ckennelly@google.com>
Subject: Re: [PATCH v5 08/24] sched: Introduce per memory space current
 virtual cpu id
Message-ID: <Y3KpxR4ABRxvD+kj@google.com>
References: <20221103200359.328736-1-mathieu.desnoyers@efficios.com>
 <20221103200359.328736-9-mathieu.desnoyers@efficios.com>
 <CALCETrW1doHX3=za+KDuB=4y+wHsnaZpVkDP3OhZXGrQU2iffw@mail.gmail.com>
 <2f191ddb-de89-52c0-e7da-26ac0239b8fe@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f191ddb-de89-52c0-e7da-26ac0239b8fe@efficios.com>
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

On Fri, Nov 11, 2022, Mathieu Desnoyers wrote:
> On 2022-11-10 23:41, Andy Lutomirski wrote:
> > On Thu, Nov 3, 2022 at 1:05 PM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> > Also, in my mind "virtual cpu" is vCPU, which this isn't.  Maybe
> > "compacted cpu" or something?  It's a strange sort of concept.
> 
> I've kept the same wording that has been introduced in 2011 by Paul Turner
> and used internally at Google since then, although it may be confusing if
> people expect kvm-vCPU and rseq-vcpu to mean the same thing. Both really end
> up providing the semantic of a virtually assigned cpu id (in opposition to
> the logical cpu id on the system), but this is much more involved in the
> case of KVM.

I had the same reaction as Andy.  The rseq concepts don't worry me so much as the
existence of "vcpu" in mm_struct/task_struct, e.g. switch_mm_vcpu() when switching
between KVM vCPU tasks is going to be super confusing.  Ditto for mm_vcpu_get()
and mm_vcpu_put() in the few cases where KVM currently does mmget()/mmput().
