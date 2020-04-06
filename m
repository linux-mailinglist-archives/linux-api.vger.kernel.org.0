Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E52119FD3F
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 20:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFSdW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 14:33:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43925 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDFSdW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 14:33:22 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jLWYh-0005jG-I6
        for linux-api@vger.kernel.org; Mon, 06 Apr 2020 18:33:19 +0000
Received: by mail-lf1-f69.google.com with SMTP id b16so5482618lfb.19
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 11:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90HV19v61/oJlZKRSYQx/Q+sNGoHReecpevkIbBQOKA=;
        b=WkfvjoVGXa4XBup/kcUQXot6orsKMjkKsDtP8dHAJsL4heRJjmzhMXCacVAyA46VR4
         N5XvOuCHyt9OEqZgCO/XzFKnYt9/9LeiPrkMOSj/ntqZJjZus9Hph+cMhPZQO1bHsQuS
         AZ5Sa9FBTug5pvvEBSB6RpLVp/SxVgm7r7YLi1+zD+NjZiI9+zK7mMtv/niIVaywHvTk
         WGLYPzGc2bSCToim7ugXINw15Ak9gCJM/3Cd0ZQGyMZkABoNN5zpy0inxR5JeYvP9oWZ
         JsAlzUNguvfOtfEsweFuvLlq+cgHq7UW6jojd7oUh6HJV+dbJksxKvDN44aewBndzWA2
         lKyw==
X-Gm-Message-State: AGi0Pub8y9tCcVlV987f8TyN9xaDcBzAS0rlx3ga5uwR32izfNHKioU8
        ktOmXKnutLCTkzMewu5wei/188PFacTr6IeR5E64rEqp2s4vFmObbyM2XGHnfO9XK3Udrav+93M
        jWUZQXkMQBACD7yxUJ6PBAJV3g6+AddWdY1ZjGSpHZ8ht9jH1hkMyuw==
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr12759344lfo.69.1586197999025;
        Mon, 06 Apr 2020 11:33:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypITp3xnqIy0LanaMOSTQptCQgmvJbvvW4mayLi3SKGRQ/k7zk5c43j4cUifOZGvLhKkDHOjqHFB4PoDD+QQXoU=
X-Received: by 2002:ac2:57cc:: with SMTP id k12mr12759324lfo.69.1586197998800;
 Mon, 06 Apr 2020 11:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com> <202004060854.22F15BDBF1@keescook>
In-Reply-To: <202004060854.22F15BDBF1@keescook>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 6 Apr 2020 15:32:42 -0300
Message-ID: <CAHD1Q_xwR4OqsF8n3VJXknZ5QgpLWPQ3YTuztTgn0GTMR0vgKA@mail.gmail.com>
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Thanks Kees! I was expecting this could be merged in the current
window, but there's really no problem in waiting for the next!

Cheers,


Guilherme
