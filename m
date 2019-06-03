Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6133470
	for <lists+linux-api@lfdr.de>; Mon,  3 Jun 2019 18:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfFCQBi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Jun 2019 12:01:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38356 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfFCQBh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Jun 2019 12:01:37 -0400
Received: by mail-lf1-f68.google.com with SMTP id b11so14041054lfa.5
        for <linux-api@vger.kernel.org>; Mon, 03 Jun 2019 09:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwAb+fjZakb4SE3XBU2vDo+/FsY9YcZ27a86p6XEaAs=;
        b=RAknaK6HJEQ5zkQCebN0zIeweiFarG87mqZWgTXpU/mJYEt/DEie3H3GUrpMAkizhf
         DAjrek0lkfPev895ypNRKOioKwTHoHppJhQCGVAq+NcSFX9QQKad4aQE4NgXUszbotod
         HpqE5XLtyZaVR5/qdNcdgb7ceGwsUQvR666euqtSsqc3OmniQ2styCZ5A6fa8wFzmYab
         XQWs/R8Zv9uWMeeBYycMepmlBwpgKHulJsqz5096zetgsMifJSoInjVF+zauJ7Lcd+ZK
         poQFphqqutbXYOSTji0TJpFkZiZboByLaWGvrwJDqBIG4csRSA2uepIebTq5Rhzk3wDG
         LSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwAb+fjZakb4SE3XBU2vDo+/FsY9YcZ27a86p6XEaAs=;
        b=j/gtRz6yoSm3aoDgOH4wg2f9JLlBWYJA5Euopdas9dTO2OVWfcKaZ5zNK0yQlGhQI/
         7rBKydn3/JDyCmc7uyU+DflMzxNk39yVtF6G2oT5J4cVw85zwHnsVsUS27VRiHFanLt6
         4MxbXViLNJRLcWhBgI+z8QLTdvBCVHIIlx7X9anG6bOKue9wt50+HFUUpz3lpSw5DtpG
         jX3X/+dsAdWNFzJX/FYzdc4u154QV42MQuicsiH7b40EtbFsVA/jxmvJxmrfgNP4ETzz
         JXwR/RuWBJRX0PKS9i45hGSzpq3iEImFSS1G1ZRILgSJWjGr6uaClMLocadkzB6KThqA
         hRbA==
X-Gm-Message-State: APjAAAX4UPanenjDj8b1iNCYlS4i9TaIhKZDBEe64LuJIOlnAhoEjfa2
        AmRaMRDPMCMBAghbfmuHjt1B3MzLVmM4abVGq2dx
X-Google-Smtp-Source: APXvYqzF84jTm/2bsJE8Z7872PStSoK3LKry51awtLL9AllXtZ9eS6eWxt9+Bys/+Qo1UsfILlV7LgRg51RsyxVhV98=
X-Received: by 2002:ac2:446b:: with SMTP id y11mr9514878lfl.158.1559577695379;
 Mon, 03 Jun 2019 09:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <fadb320e38a899441fcc693bbbc822a3b57f1a46.1559239558.git.rgb@redhat.com>
In-Reply-To: <fadb320e38a899441fcc693bbbc822a3b57f1a46.1559239558.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Jun 2019 12:01:24 -0400
Message-ID: <CAHC9VhQZuOXiK4yj4xeRwGF_qepeg7qDL02GDdYhwTNRLRdmPA@mail.gmail.com>
Subject: Re: [PATCH ghak90 V6] fixup! audit: add containerid filtering
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 1:54 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Remove the BUG() call since we will never have an invalid op value as
> audit_data_to_entry()/audit_to_op() ensure that the op value is a a
> known good value.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditfilter.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks for sending this out.  However, in light of the discussion in
the patchset's cover letter it looks like we need to better support
nested container orchestrators which is likely going to require some
non-trivial changes to the kernel/userspace API.  Because of this I'm
going to hold off pulling these patches into a "working" branch,
hopefully the next revision of these patches will solve the nested
orchestrator issue enough that we can continue to move forward with
testing.

> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
> index 407b5bb3b4c6..385a114a1254 100644
> --- a/kernel/auditfilter.c
> +++ b/kernel/auditfilter.c
> @@ -1244,7 +1244,6 @@ int audit_comparator64(u64 left, u32 op, u64 right)
>         case Audit_bittest:
>                 return ((left & right) == right);
>         default:
> -               BUG();
>                 return 0;
>         }
>  }
> --
> 1.8.3.1
>


-- 
paul moore
www.paul-moore.com
