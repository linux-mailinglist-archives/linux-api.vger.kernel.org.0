Return-Path: <linux-api+bounces-1227-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFE8963C8
	for <lists+linux-api@lfdr.de>; Wed,  3 Apr 2024 07:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B40C1C230AD
	for <lists+linux-api@lfdr.de>; Wed,  3 Apr 2024 05:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ED1481B9;
	Wed,  3 Apr 2024 05:05:19 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0413FE37;
	Wed,  3 Apr 2024 05:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120719; cv=none; b=DPkwXUTFLmfXZghx/E6OwqMS5pNWSV6nHeIUXxJxhj2RZXrlC6JivnPKaE6RJkgjriR2tRegnhrNxhkHlpEcJcPG2WGtTUxtNXjXsFn4g+U2X+j2WM2rKKNPF7sPMp9mnXjWVATC9wvOrFDU9TbD9l5u01nFQjkyisE7+bZWr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120719; c=relaxed/simple;
	bh=aHUR5HJDnC3O9uH33glNcmXzhfDjVK7VHTG5hNICwys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hm0Bz+6KmI+bzL/X6+F4vcMNaGJRxAMbwWJKbBDF0sJVep7WJ54s1tC/ZBTAAYttoNrrcwwa/9ER2JtwjwNI68F7BdNPP+lgzDpOj+EWZxcT7d19/DP5P0B1deOyIMMap8XwRpIzs7ptoCO/xjwxUo2ZKFxM4+jFTiDvrBfhXpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-515d55ab035so2781383e87.2;
        Tue, 02 Apr 2024 22:05:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712120716; x=1712725516;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEvcw3g9+Gve6vcNPPTuwFs6cAwm1uzLANZwSCj4W5Q=;
        b=dbBdCPwCSUHQ6rP7ZFT+YOIrYi0VFS9s1D/i3WWCNoIr4x2roC3RxpYqSGPuO1riaJ
         f5Nowgqm0JU14+kvtqTUsAbTCuuuJ3CHOU4ZjFZU0+UufTuPBzydmDGmjYMwlqI5f+41
         yCFbPz8+9epWgWuMmvLa7RsPris7NlHJwGa7hg4MTjgeQZkwBLZc29Bc0IeC4+afZEJf
         vo6MRgkXjyttL4PumGZU+X7i0+GYXbqnZtX5IH3XKKpNRepFzjmEfjDWVB0cSGv07zm1
         tpsmg5XGss5vUWjMiETAxhSoZdiebJNCme0JDL1tpL/9SIKnfXqRGlVG2MRD6CqNB/r7
         3YVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd2tpSakBrrjbUqee5mpvIYxNAAuIGBNb3vJbtuMcr4HfsSIbFF2Y3FCnY1OLc4Y8466V5arKUeoCL1APkoCQH4srT0PMDJSeG8BcOBHFXf2I30xAgtQqTpkuKRU2EDG92MLkH4F4CVK0/MOfr/+eWieVAYaYdXVrpuD/eGGPysGpElYY=
X-Gm-Message-State: AOJu0Yz7/LUSKM2qqFLykxsLY9tjnHNfoZDNT7qXtQHNN7EvxkPvuBLP
	XhL/6KyMryZGRaZhR8g9SfH8OAfVc/+zfCVShSvayuysAfR81wMY
X-Google-Smtp-Source: AGHT+IFJB4icCKS9Vxed+4kXEBNoxd194M09DKqKEAXd5k0IM8YQkZGTfhenihGFk2Rtul/T3XXceg==
X-Received: by 2002:a2e:9896:0:b0:2d7:9d4:f31c with SMTP id b22-20020a2e9896000000b002d709d4f31cmr8346706ljj.15.1712120715944;
        Tue, 02 Apr 2024 22:05:15 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id v14-20020a05600c470e00b00415f496b9b7sm4598776wmo.39.2024.04.02.22.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 22:05:15 -0700 (PDT)
Message-ID: <211f3c45-7064-475b-b9e1-f6adbbba8879@kernel.org>
Date: Wed, 3 Apr 2024 07:05:14 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] VT: Add KDFONTINFO ioctl
To: Alexey Gladkov <legion@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org, Helge Deller <deller@gmx.de>
References: <74ca50e0-61b1-4d4c-85dd-a5d920548c04@kernel.org>
 <cover.1712080158.git.legion@kernel.org>
 <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <7cd32f988a147d7617742c9e074c753de0c6bc1f.1712080158.git.legion@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

First, there was no need to send this v4 so quickly. Provided we have 
not settled in v3... This makes the review process painful.

And then:

On 02. 04. 24, 19:50, Alexey Gladkov wrote:
> Each driver has its own restrictions on font size. There is currently no
> way to understand what the requirements are. The new ioctl allows
> userspace to get the minimum and maximum font size values.
> 
> Acked-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Alexey Gladkov <legion@kernel.org>
...
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -479,6 +479,17 @@ static int vt_k_ioctl(struct tty_struct *tty, unsigned int cmd,
>   		break;
>   	}
>   
> +	case KDFONTINFO: {
> +		struct console_font_info fnt_info;
> +
> +		ret = con_font_info(vc, &fnt_info);
> +		if (ret)
> +			return ret;
> +		if (copy_to_user(up, &fnt_info, sizeof(fnt_info)))

sizeof, I already commented.

Now you leak info to userspace unless everyone sets everything in 
fnt_info. IOW, do memset() above.

> +			return -EFAULT;
> +		break;
> +	}
> +
>   	default:
>   		return -ENOIOCTLCMD;
>   	}

thanks,
-- 
js
suse labs


