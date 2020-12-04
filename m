Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262CC2CEEC1
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgLDN0F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 08:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbgLDN0F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Dec 2020 08:26:05 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE2C061A4F;
        Fri,  4 Dec 2020 05:25:24 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so5341740wrt.0;
        Fri, 04 Dec 2020 05:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NJ97JT73CBxTHdvfTcI/LSNJGgKg1Av6EnVkFytDfl4=;
        b=cvAcAoCZk1z11KZq4HnKa0sC7a57HprhKSXOF3h2UcaEOrMgp0zsrJs/cM89daC4xu
         P9HddpuO8n1a9FLE21PlEO06hxDH1nIDYM+V9pDnVKxqT++C7uRHeSwIxIIGnOi4ZSdU
         KiOgXPl17BuLdVRgFAqBMWp49KUCWpqe32iu7KSeD6LJPMxyQFvS6oeP2ZLb5b8JqLKo
         nZxdzr6OZHDxz2VXupPw+UJZTIetzTIjRKUD/6y5wjKtkFxfMlxh5Y8ZtnaFDLzAh5fw
         DouqpXPR2EE2lJun+Dk4774zvtvI9rrKiB2J6dy5H4t7BInt/g8vcvxBYxroLSLUJXi1
         oLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NJ97JT73CBxTHdvfTcI/LSNJGgKg1Av6EnVkFytDfl4=;
        b=RsLKpRK1j7E7s1G3thGUd5SgYwevhDORJ8pUKgrSXuD3KmeKWRy1h3y3LMotmoP014
         TY1cUNYGF+IkMJTWgBYmeOGkBxZe07WPWJRmzfIqjlnZlMrZf0AP1+top46AlD8alBO9
         zdAlabBfddaMUWasVQpk1sWMX50JRAdwAzCLh3d+LeXUIHpY/jNaxhMYaTq1jL7TGlst
         7evt/S+Bd7wzy1Amx3Jq04BnkE0JjrSYrHgNwL0Nyna5wViy5Cp177mZzl60yy/WYoPe
         GFE0uJTbV3s6vxtN8MqzPXovWShvJVkKsj2bE6wT3CM606GUpalxjFUWRUbSXHud/DOJ
         GJqA==
X-Gm-Message-State: AOAM530aQWM/TCDHDqqCeAsKeMRG4TY8nJJ7DSD0RwRmoxQL+84FY+KZ
        eD9uB7v7f0lpiyLe3GsoBuc=
X-Google-Smtp-Source: ABdhPJyXmFc/9Uyjh3Lv3QX/ycyHZ230E8YZyXQAH8E8GE/Comlg/sWUTKr1hwO9R4/meXE0+s8DWg==
X-Received: by 2002:a05:6000:c7:: with SMTP id q7mr4960527wrx.137.1607088323645;
        Fri, 04 Dec 2020 05:25:23 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id r1sm3565703wra.97.2020.12.04.05.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 05:25:22 -0800 (PST)
Subject: Re: [PATCH -V7 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag
 MPOL_F_NUMA_BALANCING
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        linux-api@vger.kernel.org, Mel Gorman <mgorman@suse.de>
References: <20201204091534.72239-1-ying.huang@intel.com>
 <20201204091534.72239-3-ying.huang@intel.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <4c10125a-cbe6-7dff-3b57-c3480e913c5f@gmail.com>
Date:   Fri, 4 Dec 2020 14:25:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201204091534.72239-3-ying.huang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Huang Ying,

Please, see a few fixes below.

Thanks,

Alex

On 12/4/20 10:15 AM, Huang Ying wrote:
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> ---
>  man2/set_mempolicy.2 | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
> index 68011eecb..fb2e6fd96 100644
> --- a/man2/set_mempolicy.2
> +++ b/man2/set_mempolicy.2
> @@ -113,6 +113,15 @@ A nonempty
>  .I nodemask
>  specifies node IDs that are relative to the set of
>  node IDs allowed by the process's current cpuset.
> +.TP
> +.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
> +When
> +.I mode
> +is MPOL_BIND, enable the Linux kernel NUMA balancing for the task if

.B MPOL_BIND

> +it is supported by kernel.
> +If the flag isn't supported by Linux kernel, or is used with
> +.I mode> +other than MPOL_BIND, return -1 and errno is set to EINVAL.

.BR MPOL_BIND ,

A minus sign should be escaped:
\-1
See man-pages(7)::STYLE GUIDE::Generating optimal glyphs)

.I errno
.BR EINVAL .

>  .PP
>  .I nodemask
>  points to a bit mask of node IDs that contains up to
> @@ -293,6 +302,11 @@ argument specified both
>  .B MPOL_F_STATIC_NODES
>  and
>  .BR MPOL_F_RELATIVE_NODES .
> +Or, the
> +.B MPOL_F_NUMA_BALANCING
> +isn't supported by the Linux kernel, or is used with
> +.I mode
> +other than MPOL_BIND.

.BR MPOL_BIND .

>  .TP
>  .B ENOMEM
>  Insufficient kernel memory was available.
> 
