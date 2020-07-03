Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747ED213954
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 13:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgGCLaa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Jul 2020 07:30:30 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35274 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCLaa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Jul 2020 07:30:30 -0400
Received: by mail-ed1-f66.google.com with SMTP id e15so27403689edr.2;
        Fri, 03 Jul 2020 04:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t6wJkMnW5nIgCGC6amjGaAv58QMzf2CtwMzccOFo60Q=;
        b=fl4qocvlaYfmZGKWo0ocpzr1tokteh7Vih6aOdu35dOBmB+xKWUY2oC2CnyPZqBMdt
         A1mgqJvwDDNm4XJtJhUeG21zvOWQjT0N58L31tgssOu90OMxafCRI6+nxP0ifuyHGn2L
         QzsMz7+9POFwmDA3MTlmpXgPaFRuwtyW9obbUun0GZ4rsAm8QCDa619PeMHV/5ty1ZiB
         8MCHQn8MS8AYNfPkzC9B4S1DSYAcAbTlVOhOP+ag/x7vfCgq2Llz37EuP+jsHq6shCS0
         Xx3cfgSZEnDHzs37vH/66YJQHh/y0M3ytmMbYTbF29IAOmjnuQjdBIj+qdk5uGuO36K4
         86ag==
X-Gm-Message-State: AOAM532izvuVRgfQIhgQSjpv0QF+VUnB69rkKUROXxZuuYMmUZy6xMRX
        i9D7Qct7vjqBwlpb466027M=
X-Google-Smtp-Source: ABdhPJy019JabBFEmKZGz1Cc9GAUt3rvJgtYoQhP4TF0Qd+VrMWkh+pYbS4BdGiSV0sxR5zA36zkqw==
X-Received: by 2002:aa7:db11:: with SMTP id t17mr38671552eds.365.1593775828311;
        Fri, 03 Jul 2020 04:30:28 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id v19sm14454298eda.70.2020.07.03.04.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 04:30:27 -0700 (PDT)
Date:   Fri, 3 Jul 2020 13:30:26 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Catangiu, Adrian Costin" <acatan@amazon.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "len.brown@intel.com" <len.brown@intel.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "wad@chromium.org" <wad@chromium.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "bonzini@gnu.org" <bonzini@gnu.org>,
        "Graf (AWS), Alexander" <graf@amazon.de>,
        "MacCarthaigh, Colm" <colmmacc@amazon.com>,
        "Singh, Balbir" <sblbir@amazon.com>,
        "Sandu, Andrei" <sandreim@amazon.com>,
        "Brooker, Marc" <mbrooker@amazon.com>,
        "Weiss, Radu" <raduweis@amazon.com>,
        "Manwaring, Derek" <derekmn@amazon.com>
Subject: Re: [RFC]: mm,power: introduce MADV_WIPEONSUSPEND
Message-ID: <20200703113026.GT18446@dhcp22.suse.cz>
References: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B7793B7A-3660-4769-9B9A-FFCF250728BB@amazon.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 03-07-20 10:34:09, Catangiu, Adrian Costin wrote:
> This patch adds logic to the kernel power code to zero out contents of
> all MADV_WIPEONSUSPEND VMAs present in the system during its transition
> to any suspend state equal or greater/deeper than Suspend-to-memory,
> known as S3.

How does the application learn that its memory got wiped? S2disk is an
async operation and it can happen at any time during the task execution.
So how does the application work to prevent from corrupted state - e.g.
when suspended between two memory loads?
-- 
Michal Hocko
SUSE Labs
