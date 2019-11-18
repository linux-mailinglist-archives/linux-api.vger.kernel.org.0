Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9018C100C3F
	for <lists+linux-api@lfdr.de>; Mon, 18 Nov 2019 20:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKRTgu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Nov 2019 14:36:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47073 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRTgt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Nov 2019 14:36:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id n23so15559510otr.13
        for <linux-api@vger.kernel.org>; Mon, 18 Nov 2019 11:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUl0aHWxnRdGIJQaaNYqf/1e2TYCVGxY+g4UhFUHwCk=;
        b=KUk/R1TQPGb+tLW1IrCyhIFesOsAWIogNaBJJZDsZ90Jun0S7sQT/xNmr44phxdfxY
         01FCu4hwcinKCuvU6ySkH61de4ZUGUhe0jOWYIq/39Fi5cz3TPG436FnAJHa4t3/FNA8
         FITQpQbQ5sDJaRkO9cpy2pAvR7DNRX+WSa/o8QCI/vdNF6YeN6bydh8N7MEdUlEoOTWp
         +LPCzqV8waygLHdwUsWYEDqh2HhK70b+7EczlnYTsPs3NQoectm0XTnzLF1feeAqBXAD
         tRjLkCVm89rRaaiBaLdiMptw3sihutzBhpxVwHQnKy9UhWEePeYBLbMeQYMnLZoT3jMz
         g0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUl0aHWxnRdGIJQaaNYqf/1e2TYCVGxY+g4UhFUHwCk=;
        b=U7YfO5Jr+qodTgBO8vcu8JezKbBdo6/IKq7YzPU+gs+qs1Tuh5RZgOhriQpFxXzl8O
         O2L1CZiEJPe9Na4JCs/4ncovrdiYD1qKUiE42Jo65aJOME8SzDUK/RmNqkH4nH7oWYnv
         KgVT9N240ClcVCmsZNrhLbC/0ILuBpTSzctEoI9Ruf572qb4UWBXr59nmcJIO/1TvYEL
         vAXKQbL/TbFTtEmCSOzn+G3bETd11XFxaeUTocsyRZslys/qNTESYT6LiwQ/UizKrpjW
         23kbkYmIsE0xT9dLW4RaH4kqtXj9klg5R/zfvdiwCNFdx2Vy3YOjeafiAZJ1H4y3qJxH
         xhSQ==
X-Gm-Message-State: APjAAAW8MFf85eKyF8GN3sY9Ld5rjffJ/D2LtSzKb6BnmOT7nE/t9o0z
        n3sWc/fie835t/qbiuv4V/iDBBPVPoTRTizWFLfNsQ==
X-Google-Smtp-Source: APXvYqytVGe8Ge88fM2s8MWcASEkCS/Y2W4/jjH09IuPU3wE6qMQlrMmcrf0WnuNToQB9hGvlODs6rvbSfcN88ERDds=
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr704063otb.183.1574105808669;
 Mon, 18 Nov 2019 11:36:48 -0800 (PST)
MIME-Version: 1.0
References: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
In-Reply-To: <1574096478-11520-1-git-send-email-prakash.sangappa@oracle.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 18 Nov 2019 20:36:22 +0100
Message-ID: <CAG48ez3HfUx2aRvqR_bWnGoTshrHnUzxUNt7K6Sv7cqtPDWaWw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/1] CAP_SYS_NICE inside user namespace
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 18, 2019 at 6:04 PM Prakash Sangappa
<prakash.sangappa@oracle.com> wrote:
> Some of the capabilities(7) which affect system wide resources, are ineffective
> inside user namespaces. This restriction applies even to root user( uid 0)
> from init namespace mapped into the user namespace. One such capability
> is CAP_SYS_NICE which is required to change process priority. As a result of
> which the root user cannot perform operations like increase a process priority
> using -ve nice value or set RT priority on processes inside the user namespace.
> A workaround to deal with this restriction is to use the help of a process /
> daemon running outside the user namespace to change process priority, which is
> a an inconvenience.

What is the goal here, in the big picture? Is your goal to allow
container admins to control the priorities of their tasks *relative to
each other*, or do you actually explicitly want container A to be able
to decide that its current workload is more timing-sensitive than
container B's?
