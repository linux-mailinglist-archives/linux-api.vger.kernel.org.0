Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FB62459F0
	for <lists+linux-api@lfdr.de>; Mon, 17 Aug 2020 00:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgHPWqY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Aug 2020 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729579AbgHPWqT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Aug 2020 18:46:19 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C5C061388
        for <linux-api@vger.kernel.org>; Sun, 16 Aug 2020 15:46:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so6858973pjx.5
        for <linux-api@vger.kernel.org>; Sun, 16 Aug 2020 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdd6W0wjQY4twkrWmtbJVXisCwlRs5bWGrujUBo8Nwk=;
        b=0PeI6Z1ecW8efJzLFC+P8s1OAkzNy/oopjAlpwdzDP3uBqFkzuM0LC7h2EtUvfrtXA
         H+KPQMbotMmqQMr8P1MNXZgncjh6panXS2zxueg/UQK8u55yimqp19q2O1qmJlMboUES
         wLW9x5yYq18B2w7E+DUwjH6CG1fyL99VmUoHlERhAv6vJWsbsCoT7gU0ueR+003bhM/9
         6BxU2M/y03cfgbvMrygaTCwgmXWcO/G1oRsWk6wGeZnbQEYF1aoqZUxh36DXDIGlGGkp
         xE8zJPR6Qzexcme83X93JWu1z7YWUiNLMlNDemL2M7hWnVysRVEhUhC1johnNvKiSW/P
         G34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdd6W0wjQY4twkrWmtbJVXisCwlRs5bWGrujUBo8Nwk=;
        b=bCfVJtTUfPSlPRtuL9p087fdVYACF7JZyiJSxJZKjL5KIq6A2hkd4G/blg57+j7s8S
         7FlFHs+pa2fAerPguvWYp3luP04R40rmjsCQv5+8oBPZHtto2wmWTQle1Ya1UcuAqrLN
         BDlK2OCP+Yfk5xTmrRyYJHeY8wobu4mZ9fiVeKBgvshJ3fVyNvHLKZ95fXv0YTjyb8mE
         zwKPeaxTJIlHwn1lIrNtWHv52mbPNATHW+Izl/As1GDQGUEXG54h9Y+kGpu8DRIxdiWY
         RW90tP+zJ5JrVKq6ig04HGXiUf6YCROnJbQvbKmpt+XVzY7IZVKVxnYUxCqMTstKaDJN
         GQtg==
X-Gm-Message-State: AOAM5308I+30bEalF9xvuwtQTtnr2CnLclVr4NtT9XN5O83XSJwRPe63
        4RvQJ4kerMN5/d9Lvv+lOY4dmg==
X-Google-Smtp-Source: ABdhPJx2RyitijhpB8HyHg+v11L1TWUQym0dBB5Ie1aetMyyLQqZUL93SvmgA77M5oT0IrbM+Urt/w==
X-Received: by 2002:a17:90a:24e9:: with SMTP id i96mr10393612pje.148.1597617977195;
        Sun, 16 Aug 2020 15:46:17 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a24sm16311197pfg.113.2020.08.16.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:46:16 -0700 (PDT)
Date:   Sun, 16 Aug 2020 15:46:08 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Murali Karicheri <m-karicheri2@ti.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <nsekhar@ti.com>, <vinicius.gomes@intel.com>,
        <kuznet@ms2.inr.ac.ru>
Subject: Re: [net-next iproute2 PATCH v4 1/2] iplink: hsr: add support for
 creating PRP device similar to HSR
Message-ID: <20200816154608.0fe0917b@hermes.lan>
In-Reply-To: <20200806203712.2712-2-m-karicheri2@ti.com>
References: <20200806203712.2712-1-m-karicheri2@ti.com>
        <20200806203712.2712-2-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 6 Aug 2020 16:37:11 -0400
Murali Karicheri <m-karicheri2@ti.com> wrote:

> +	

> +		print_int(PRINT_ANY,
> +			  "proto",
> +			  "proto %d ",
> +			  rta_getattr_u8(tb[IFLA_HSR_PROTOCOL]));

Since this unsigned value, you probably want to use print_uint, or print_hhu.
Also please put as many arguments on one line that will fit in 80 (to 90) characters.

	if (tb[IFLA_HSR_PROTOCOL])
		print_hhu(PRINT_ANY, "proto", "proto %hhu ", 
			  rta_getattr_u8(tb[IFLA_HSR_PROTOCOL]));
