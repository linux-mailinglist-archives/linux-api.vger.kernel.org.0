Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3770719CAA8
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732625AbgDBTzl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 15:55:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43887 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBTzl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 15:55:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id 91so3774752wri.10;
        Thu, 02 Apr 2020 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BcmFqDRbxV7k8MbOseeqyz7EYpcV1Zb/V53+t/VajDo=;
        b=LE3S+J5M9WvKalThEsVmIjXdYuHah3ihfcUxdKe/mqr+i276CmPAqe50+Ni/yHEhQR
         h+p5bDy61tdCp+xTB4Dfi7pvRZFIjyBroW+h4US4BSFf6Pg4msnHZphvZl2vR8uXV+3O
         RU2+hYc95lQ56RrAEwtD+XRjDtYe52WWTjh7YfqxI4oGNh7KTM6bYAfc+wmTYxwCxwbh
         h+OM8SWopvEa1X7EbyzY2XS67Vc/WVdZZBYcxJdR46F8h51dFALGizAlx+cm7rQYWQht
         b/HXjYOX3u/nCo5KcYXHMoyanVhfwWNIOk0CVm6khNeNY12GhydoxFm076XKlQ9hs8sV
         4rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BcmFqDRbxV7k8MbOseeqyz7EYpcV1Zb/V53+t/VajDo=;
        b=G1Ddcdmuc/eia6iwGuOZra6qRUB2WhI7zYLiR+zMTk53BYLutpX4Xw6WF824GB/CXi
         ksUx3f8TNB+NvbKVslUGAC2c4BGyg00dygRAGLXhphtY9CWcv37XoedjIfem14x5kO0+
         y+sUHlTvSzmqRUs8FSnEqXM9mCYwUYt3yDWOU/attdgxthtI1Y4qVTR2xmqA9aLqWg/M
         PgPBuaqdNTygupfVkgABEYzJXWSFC6BjdZHV41upkEuDO+3oObrgMNWw0XRi/hJJyp1Q
         YG2bR/VK19hUmY1ySjdjrpU0LmCKLsDuG1exPyYurKctadj3K+/UmGW1k28nAOmc8+GS
         eiRw==
X-Gm-Message-State: AGi0Pub8OzZQzCs8fnNRYboUbAyJ06La2aCfCgHfeBPGoUMvB5bvzKdQ
        osDnfgj/H//s2T++xNVmE0c=
X-Google-Smtp-Source: APiQypKL1znVbHVjL57RDlmjrQEN7/rVM56ybeSaamsVpgylN+m80jP5w2571IWe+9qGNuRQ05J5dg==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr5158002wro.68.1585857338949;
        Thu, 02 Apr 2020 12:55:38 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id p10sm8674461wrm.6.2020.04.02.12.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 12:55:38 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Linux API <linux-api@vger.kernel.org>,
        Eric Rannaud <eric.rannaud@gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <aacf7159-7aa9-97d8-393b-ab6db3218347@gmail.com>
Date:   Thu, 2 Apr 2020 21:55:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Eric,

On 4/2/20 4:23 PM, Eric Rannaud wrote:
> See Linux source as of v5.4:
>   kernel/time/posix-clock.c
> 
> Signed-off-by: Eric Rannaud <e@nanocritical.com>

Thanks! Patch applied.

Cheers,

Michael

> ---
>  man2/clock_getres.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/man2/clock_getres.2 b/man2/clock_getres.2
> index 0154f9d32473..71f7f8dfa662 100644
> --- a/man2/clock_getres.2
> +++ b/man2/clock_getres.2
> @@ -260,6 +260,10 @@ specified in a call to
>  .BR clock_settime ()
>  is not a settable clock.
>  .TP
> +.B EOPNOTSUPP
> +The operation is not supported by the dynamic POSIX clock device
> +specified.
> +.TP
>  .BR EINVAL " (since Linux 4.3)"
>  .\" commit e1d7ba8735551ed79c7a0463a042353574b96da3
>  A call to
> @@ -276,6 +280,11 @@ clock.
>  .B EPERM
>  .BR clock_settime ()
>  does not have permission to set the clock indicated.
> +.TP
> +.B EACCES
> +.BR clock_settime ()
> +does not have write permission for the dynamic POSIX
> +clock device indicated.
>  .SH VERSIONS
>  These system calls first appeared in Linux 2.6.
>  .SH ATTRIBUTES
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
