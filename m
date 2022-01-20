Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9E495332
	for <lists+linux-api@lfdr.de>; Thu, 20 Jan 2022 18:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiATR2Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jan 2022 12:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiATR2X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jan 2022 12:28:23 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46CEC061574
        for <linux-api@vger.kernel.org>; Thu, 20 Jan 2022 09:28:22 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id g81so19845874ybg.10
        for <linux-api@vger.kernel.org>; Thu, 20 Jan 2022 09:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5kxtJVtF3SaErQNcU0YF44etjr8OoNxVIxLQIcs0s0=;
        b=PqgBMyGno5bkuq6yS2SgRqsITa8SCLYe4Y5r0Vvpk6N0GVUDx378Qh6zJ+XMuu0p/J
         xrttC/Os1WjFxmLCu7yZlJJnB6lHStZZUpn7gEt38OqH6gjFOXVZurCH1NDI0hEqVrFw
         CuupxOwqVW4nJRlwXNWFZyX6e9InGSxlBKlMeafU7nROV0gR1Ie+3wEMZeSnaIcTeG6+
         6QU2AqJf1FzaMnA5xIL8mYhMn5eJ4Dvo+/SqB6xxggTEHkVsVIaG9ri03qlTlO+Uvm1P
         K5yLyGAimi4vtEUNbLdkfbFqdK+HXIEeEZ0t3n8VI9e1XC4qO3qkV/LvEBoGeRUTA05a
         YEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5kxtJVtF3SaErQNcU0YF44etjr8OoNxVIxLQIcs0s0=;
        b=OWBrHYm+ACyRvKMcZsp+jMbt6CkaCqbMnyfkJJ0ZVSbCTsNtUGAOuD2XZFoQR2hXl6
         CvpSoggIP8y2WCuanWBT5YEHC8EKa8Y1fa9170OCSCF67ga6ebSzvvmZ7a65iShSkO3A
         0n4m2upLHtnYwKu7DtutzR9iOqllhB5AItplqZR9WA7QOaZiJgwUZgVRpK8a/MzotDuw
         WckZ+9VH6fGl2KtkHZecG7xTXZ8bbGUaVbXMlcqxkez2kgDveeX+iDeLIbBpxmpel0Lx
         zlOSLs6YuPR1TpYnuCeCipnMKAs97ETP/zWRgAhvtegepR/2xundnCa84gga92MZhP+B
         Cpbw==
X-Gm-Message-State: AOAM532C3yJmnLiD7IHcbxZwrDzyDOwUrvif2LKJGW5Wyb/hx1kEUhl+
        zpjkROaoLComLPgiBp5C4ZB/uHcnZRqbyKlDJLeKFg==
X-Google-Smtp-Source: ABdhPJyD12OQXWkGBGGACFai7X0br9OE/lh2j7Qt7WZjZ5D5U/g1rx+DHWdM+e3BCxhnNjNy2UhhzYVERrQ2OiRL5YM=
X-Received: by 2002:a25:550b:: with SMTP id j11mr102282ybb.440.1642699701974;
 Thu, 20 Jan 2022 09:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20220120155517.066795336@infradead.org>
In-Reply-To: <20220120155517.066795336@infradead.org>
From:   Peter Oskolkov <posk@google.com>
Date:   Thu, 20 Jan 2022 09:28:11 -0800
Message-ID: <CAPNVh5eSZHkTXUHwao1RAgdqxLJD=92A=2CDE6AN1GUgJPJvWw@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 0/5] sched: User Managed Concurrency Groups
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jan 20, 2022 at 8:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Latest version, many changes since last time, still under heavy discussion.

Thanks! I'll work on testing/integrating this patchset. I'll also
assume that my changes that added blocked worker list
(https://lore.kernel.org/lkml/20220113233940.3608440-5-posk@google.com/)
and server kicking
(https://lore.kernel.org/lkml/20220113233940.3608440-6-posk@google.com/)
are acceptable.

[...]
