Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B04B5192B19
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 15:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCYO3k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 10:29:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44748 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCYO3k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 10:29:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id m17so3324034wrw.11;
        Wed, 25 Mar 2020 07:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xK7fLCOSSVH8HJsoEd66t540+DpWVzc878w2lJBoIek=;
        b=dnhA39pPS/8f9/GN4xySx8k7TPWXzL46VPbs9cs2YTPSOW0TMM0Zc5RAKWpi8ubbjS
         J3/VtH4BlMyBK0F0QCM7VU2icxTHO95RG7tBOvggCI5ezG16ZL49l5G2tajqAADKWOrv
         3mm+gOaLKO3JqTMfaFKI09BS4HZHdH9pdXocjwW/gcxOi8JnXRa11h4S/ol7SQP9hpbG
         6JS2AK0mk9GTLZVzdSzP9l3RnJ3EjlHvbHoEA5JH5k9clj05VAbuKM2PkrM9hghA5ewb
         Mu4yn8kwqFpihtHmp36JejyF+OoF2dVzXbAT5BdU57MMuF46eg8GexqwoDh6n7EeDmIk
         gK7A==
X-Gm-Message-State: ANhLgQ2jmk2HTGh6qtsi7cSYi9Sl+5jIPvi/BkoVyr6S/RQymBTesLiv
        W75uidHapuogiyVDAmRfY8RGNjUR
X-Google-Smtp-Source: ADFU+vvV+iXXv1GpZUfxs9nW5CvCN4kTMNBy1SnvAwfCo+uprHM46YrQo6ZhbZ/Dwea7ETji/N05WQ==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr3723218wrq.248.1585146578476;
        Wed, 25 Mar 2020 07:29:38 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id b15sm33619364wru.70.2020.03.25.07.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:29:37 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:29:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v2 2/2] kernel/sysctl: support handling command line aliases
Message-ID: <20200325142936.GC19542@dhcp22.suse.cz>
References: <20200325120345.12946-1-vbabka@suse.cz>
 <20200325120345.12946-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325120345.12946-2-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Both patches look really great to me. I haven't really checked all the
details but from a quick glance they both seem ok.

I would just add a small clarification here. Unless I am mistaken
early_param is called earlier than it would be now. But that shouldn't
cause any problems because the underlying implementation is just a noop
for backward compatibility.

Thanks a lot this looks like a very nice improvement.

On Wed 25-03-20 13:03:45, Vlastimil Babka wrote:
[...]
> -static __init int setup_numa_zonelist_order(char *s)
> -{
> -	if (!s)
> -		return 0;
> -
> -	return __parse_numa_zonelist_order(s);
> -}
> -early_param("numa_zonelist_order", setup_numa_zonelist_order);
> -
>  char numa_zonelist_order[] = "Node";
>  
>  /*
> -- 
> 2.25.1

-- 
Michal Hocko
SUSE Labs
