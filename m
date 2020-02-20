Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9CC166A30
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2020 23:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgBTWKd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Feb 2020 17:10:33 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34768 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728996AbgBTWKd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Feb 2020 17:10:33 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so83466pfc.1
        for <linux-api@vger.kernel.org>; Thu, 20 Feb 2020 14:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s3qScU3LxilFb/Kfn9mTZZUWCwQksK34AFtWAW2NAKA=;
        b=SoeRUsx69E7wQb7Ba6BGEQXkcnejiJb/5LOOV6DUIgL8w0wyvqVxQGlLh71EnkKWCl
         l/28rBfECVCfvtM3X9stjNGKEn//csKQaIMr+MQ8WRv6Gj6pPHiS1UCs33xF10rbGQiN
         rce7HxHNQ1AEEOY3qEVfOjGNC/Uvk4tiJK4/KpednpEvBjWQzq53P8tillJvpj5WFwGI
         4d6t5o1/aNL1JHoWXhXw9D6hSf4fx4yAOZG5pxbwBVTfI6xE3pMutu2n3nIt0lNiDnzA
         kQpeH09HFBLKMXbcvhfkLQ9Ql8dazbuUBo9k0NspLLvzxu6osEUDQ2Vur2Npiax5UCTZ
         yQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s3qScU3LxilFb/Kfn9mTZZUWCwQksK34AFtWAW2NAKA=;
        b=uPFOUAxH0sDM+AwaCxTTb56ozjW5TVcl2E/gHUpkbCdsB8j0cX1r+BSHZ9r73LQ3l8
         3SQMcp8DgIxZP+9i0QMKgPK+Q00vEDeNt7ZBUcLDNv28EoBU6Ub8fCPB9g/n11ortT2B
         RDA7Wr0ucb/o6zsAxtviz/EEsBPCRvtqbeklQLfsxzu0Xuc/AIbYUKlFP80IlYOFxm/p
         lqfWEFckXyQgWmIkWp7diWmSZCr+Q8oF8rRfgOD/rNOBpIVB/uQiVqEq4RSrQ4lc/NaB
         0jJdYfgOFohOijVkDN7v7UUtH3o1MavgWgvvY7Y4hQCTVQx3kauuNugXrNp2lrT3+USv
         2IKw==
X-Gm-Message-State: APjAAAWhrnIurfyB0lgPAE5QFHEB0N6eHND+C4buQA1aokTogXeO53N4
        k3lXJxiUXUx8jxkwDFhKAUwMvI7X6A==
X-Google-Smtp-Source: APXvYqwGmHNhTysHbkt132cf1y+nRJgMUHLm0pj4oiNwD0/iz+8OFMEEcG5ZrwrHnPuJR1J7+6qjhg==
X-Received: by 2002:a65:6454:: with SMTP id s20mr36095737pgv.386.1582236627248;
        Thu, 20 Feb 2020 14:10:27 -0800 (PST)
Received: from athena.bobrowski.net (n114-75-163-224.bla4.nsw.optusnet.com.au. [114.75.163.224])
        by smtp.gmail.com with ESMTPSA id f8sm383948pjg.28.2020.02.20.14.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:10:26 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:10:21 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2 00/16] Fanotify event with name info
Message-ID: <20200220221021.GA4379@athena.bobrowski.net>
References: <20200217131455.31107-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 17, 2020 at 03:14:39PM +0200, Amir Goldstein wrote:
> This is v2 of the fanotify name info series.
>
> The user requirement for the name info feature, as well as early UAPI
> discussions can be found in this [1] lore thread.

Oh, wonderful. I'm keen to have this feature come to fruition.

After my wedding, which is this Saturday (tomorrow), I'll come around
to reviewing this series.

/M
