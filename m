Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACB08196AE3
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 05:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC2DpC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Mar 2020 23:45:02 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36239 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgC2DpB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Mar 2020 23:45:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id g2so5246318plo.3
        for <linux-api@vger.kernel.org>; Sat, 28 Mar 2020 20:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tOMeImpQlmJPJjbTvFw9sx81zqMGufvcRO7HUAVzTPk=;
        b=kmDAc4XidmYjLC++7ySgAvEPEaLOzhVygGmfc3tvLrJh2pD+E++E/+6jVFBWKWDTMW
         qtadgENjxFc7lmy7E6jX5N423RFzZoxLMhSmGAGajCcLzDnXwf+q4Tta1fCod+fkQ6ta
         UF2F8doWtGBek20ce2FtM/5AVb/TUCLC/W71M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tOMeImpQlmJPJjbTvFw9sx81zqMGufvcRO7HUAVzTPk=;
        b=Kbu2FuY+QJmd5glzPxbSck7vZ4mgI5ohANKXQPLQQAvNCMvL/B9+CDYsfvKrYhsYIJ
         j0lRqo85t4ePaq7iHf07rNGE0MNmwNO9zvt7iYiEgdHds18po8oXfkMXy9CEPoJrylze
         aVAfgJMRuVmsizXLqW11wQPXMKD/yA4SF17KqUz9n02GYoQs1S+5NWYFunuvTkEkwHfN
         rJOHOnnOZZ+JgZifMQkPtnOrwGkpnWZquW+t/oSQ/OumvKBXtyiTgYipg7bEEYfpD/4b
         C1Q24yJRfUrbN4WV9Wl41d9jpoINTg4aW9EvRB0mmDBgcnQiNFRjbGARKmcTw7WHJsRF
         FBCg==
X-Gm-Message-State: ANhLgQ342w4WBD2q9WnwbPcnVBXYXx233vvbdOsaP8uYVXwibHii1oWe
        SPhaf6JyOuIQa4a1AAKe4YE8fA==
X-Google-Smtp-Source: ADFU+vvpOC+pSdCvg5rozciCqTYf3qlku+1EUAor0tvwj5i7VN8ej+h/GHJzxcyBc3ydt9oaTrxXsw==
X-Received: by 2002:a17:90a:fa17:: with SMTP id cm23mr8436144pjb.121.1585453499377;
        Sat, 28 Mar 2020 20:44:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g10sm7368484pfk.90.2020.03.28.20.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 20:44:58 -0700 (PDT)
Date:   Sat, 28 Mar 2020 20:44:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
Subject: Re: [PATCH v6 00/16] Infrastructure to allow fixing exec deadlocks
Message-ID: <202003282041.A2639091@keescook>
References: <AM6PR03MB5170B2F5BE24A28980D05780E4F50@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <871rpg8o7v.fsf@x220.int.ebiederm.org>
 <AM6PR03MB5170938306F22C3CF61CC573E4CD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB5170938306F22C3CF61CC573E4CD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Mar 28, 2020 at 11:32:35PM +0100, Bernd Edlinger wrote:
> Oh, do I understand you right, that I can add a From: in the
> *body* of the mail, and then the From: in the MIME header part
> which I cannot change is ignored, so I can make you the author?

Correct. (If you use "git send-email" it'll do this automatically.)

e.g., trimmed from my workflow:

git format-patch -n --to "$to" --cover-letter -o outgoing/ \
	--subject-prefix "PATCH v$version" "$SHA"
edit outgoing/0000-*
git send-email --transfer-encoding=8bit --8bit-encoding=UTF-8 \
	--from="$ME" --to="$to" --cc="$ME" --cc="...more..." outgoing/*


-- 
Kees Cook
